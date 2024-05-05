import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';

class Signup {
  Future<dynamic> SignupDialog(
    BuildContext context,
    TextEditingController emailContrlr,
    TextEditingController passContrlr,
    TextEditingController nameContrlr,
    TextEditingController numberContrlr,
  ) async {
    File? img;
    return showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('SignUp New User'),
        description: const Text("Make new account in app."),
        content: Container(
          width: 375,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Email',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(
                      controller: emailContrlr,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Password',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(
                      controller: passContrlr,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Full Name',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(
                      controller: nameContrlr,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Phone Number',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(
                      controller: numberContrlr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ShadButton(
            text: const Text('Pick Image'),
            onPressed: () async {
              // Open file picker or camera
              var pickedFile = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );

              if (pickedFile != null) {
                img = File(pickedFile.path); // Convert XFile to File
              }
            },
          ),
          ShadButton(
            text: const Text('Save changes'),
            onPressed: () async {
              if (emailContrlr.text.isNotEmpty &&
                  passContrlr.text.isNotEmpty &&
                  nameContrlr.text.isNotEmpty &&
                  numberContrlr.text.isNotEmpty &&
                  img != null) {
                try {
                  // Call signUpUser function to sign up the user
                  String userId = await context.read<LoginCubit>().signup(
                        emailContrlr.text,
                        passContrlr.text,
                        nameContrlr.text,
                        numberContrlr.text,
                        img!,
                      );

                  // Optionally, you can handle the result here
                  print('User signed up with ID: $userId');

                  // Close the dialog after successful signup
                  Navigator.of(context).pop();
                } catch (error) {
                  // Handle sign-up error
                  print('Error occurred during sign up: $error');
                  // Show error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error occurred during sign up: $error'),
                  ));
                }
              } else {
                // Show error message if any field is empty
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('All fields are required.'),
                ));
              }
            },
          )
        ],
      ),
    );
  }
}

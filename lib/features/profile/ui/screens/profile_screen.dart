// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sleep_manager/features/profile/ui/widgets/profile_card.dart';
import 'package:sleep_manager/features/settings/ui/screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Reference ref = FirebaseHelper()
      .storage
      .ref()
      .child('user_images/${FirebaseHelper().auth.currentUser!.uid}.jpg');

  Future<String> getUrl() async {
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  TextEditingController Contrlr = TextEditingController();
  File? img;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadButton(
                      icon: const Icon(LucideIcons.logOut),
                      onPressed: () {
                        context.read<LoginCubit>().logout();
                      }),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                      },
                      icon: Icon(
                        LucideIcons.settings2,
                        size: 30,
                      ))
                ],
              ),
              FutureBuilder<String>(
                future: getUrl(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data!),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: IconButton(
                          onPressed: () async {
                            // Open file picker or camera
                            var pickedFile = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );

                            if (pickedFile != null) {
                              img = File(
                                  pickedFile.path); // Convert XFile to File
                            }
                            if (img != null)
                              FirebaseHelper().updateProfileImage(img!);
                            setState(() {});
                          },
                          icon: Icon(
                            LucideIcons.pen,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              // Dynamically display user's full name
              ProfileCard(
                editable: false,
                title: 'Email',
                onTap: () {},
                body: FirebaseHelper().auth.currentUser?.email ?? '',
              ),
              FutureBuilder<String?>(
                future: FirebaseHelper().getCurrentUserFullName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ProfileCard(
                      editable: true,
                      title: 'Full Name',
                      onTap: () {
                        showDialog(
                          context,
                          'Update Full Namer',
                          'Update Full Name',
                          'Full Name',
                          FirebaseHelper().updateFullName,
                        );
                        Contrlr.clear();
                        setState(() {});
                      },
                      body: snapshot.data ?? 'noname',
                    );
                  }
                },
              ),

              FutureBuilder<String?>(
                future: FirebaseHelper().getCurrentUserPhoneNumber(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ProfileCard(
                      editable: true,
                      title: 'Phone Number',
                      onTap: () {
                        showDialog(
                          context,
                          'Update Phone Number',
                          'Update Phone Number',
                          'Phone Number',
                          FirebaseHelper().updatePhoneNumber,
                        );
                        Contrlr.clear();
                      },
                      body: snapshot.data ?? 'noname',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDialog(BuildContext context, String title, String desc,
      String side, Future<void> Function(String) func) {
    return showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: Text(title),
        description: Text(desc),
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
                      side,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ShadInput(
                      controller: Contrlr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          ShadButton(
            text: const Text('Save changes'),
            onPressed: () async {
              // Call the provided function with the updated name
              await func(Contrlr.text);
              Navigator.of(context).pop();
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}

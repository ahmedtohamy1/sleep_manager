import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.body,
    required this.editable,
  });

  final String title;
  final String body;
  final Function() onTap;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  editable
                      ? IconButton.filled(
                          onPressed: onTap, icon: const Icon(LucideIcons.pen))
                      : Container()
                ],
              ),
              Text(body,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 179, 179, 179))),
            ],
          ),
        ),
      ),
    );
  }
}

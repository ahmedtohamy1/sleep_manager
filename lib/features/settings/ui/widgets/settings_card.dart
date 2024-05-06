import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsCard extends StatefulWidget {
  SettingsCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.body,
    required this.editable,
    required this.toggle,
    required this.logout,
  });

  final String title;
  final String body;
  final Function() onTap;
  final bool editable;
  final bool toggle;
  final bool logout;

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 19,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (widget.editable & widget.toggle)
                    IconButton.filled(
                        onPressed: widget.onTap,
                        icon: const Icon(LucideIcons.settings))
                  else if (widget.toggle)
                    ShadSwitch(
                      width: 45,
                      value: value,
                      onChanged: (v) {
                        setState(() => value = v);
                        widget.onTap();
                      },
                    )
                  else if (widget.logout)
                    IconButton.filled(
                        onPressed: widget.onTap,
                        icon: const Icon(LucideIcons.logOut)),
                ],
              ),
              Text(widget.body,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 179, 179, 179))),
            ],
          ),
        ),
      ),
    );
  }
}

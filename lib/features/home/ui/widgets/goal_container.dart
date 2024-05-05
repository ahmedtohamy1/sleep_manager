import 'package:flutter/material.dart';
import 'package:progress_line/progress_line.dart';

class GoalContainer extends StatelessWidget {
  const GoalContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "You have achived X hours of your goal today",
            style: TextStyle(fontSize: 18),
          ),
          const Text(
            "50 % of your goal is completed.",
            style: TextStyle(fontSize: 16, color: Colors.white54),
          ),
          const SizedBox(
            height: 20,
          ),
          ProgressLineWidget(
            percent: 0.5,
            width: double.infinity,
            lineWidth: 15,
          ),
        ],
      ),
    );
  }
}

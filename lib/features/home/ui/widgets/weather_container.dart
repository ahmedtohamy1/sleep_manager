import 'package:flutter/material.dart';
import 'package:progress_line/progress_line.dart';
import 'package:weather/weather.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Weather:",
            style: TextStyle(fontSize: 18),
          ),
          Row(
            children: [
              Text(
                '${weather.temperature!.celsius!.round()}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ProgressLineWidget(
            percent: weather.temperature!.celsius!.round() /
                100, // Update percent based on your data
            width: double.infinity,
            lineWidth: 15,
            lineColors: const [
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.red,
            ],
          ),
        ],
      ),
    );
  }
}

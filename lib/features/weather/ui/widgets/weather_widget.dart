import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sleep_manager/features/weather/logic/bloc/weather_bloc.dart';
import 'package:sleep_manager/features/weather/ui/widgets/weather_view.dart';

class WeatherWidget extends StatelessWidget {
  final Position position;

  const WeatherWidget({required this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBlocBloc>(
      create: (context) => WeatherBlocBloc()..add(FetchWeather(position)),
      child: const WeatherView(),
    );
  }
}

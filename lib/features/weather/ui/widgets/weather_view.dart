import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_manager/features/weather/logic/bloc/weather_bloc.dart';
import 'package:sleep_manager/features/weather/ui/widgets/weather_display.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return WeatherDisplay(weather: state.weather);
        } else {
          return Container();
        }
      },
    );
  }
}

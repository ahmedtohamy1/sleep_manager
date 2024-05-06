import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/logic/cubit/db_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/wanted_time_to_wake_cubit.dart';
import 'package:sleep_manager/features/home/ui/widgets/avatar_name_advice.dart';
import 'package:sleep_manager/features/home/ui/widgets/weather_container.dart';
import 'package:sleep_manager/features/home/ui/widgets/home_tile.dart';
import 'package:sleep_manager/features/weather/logic/bloc/weather_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Uri url = Uri.parse('https://www.sleepfoundation.org/stages-of-sleep');
  late String wantedTimeTowake;

  Future<void> openUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> updateTimes() async {
    final times = await context.read<DbCubit>().getSleepAndWakeTimes();

    context
        .read<SleepNowCubit>()
        .setTimeFirebase(times['SleepNow'] ?? 'Not set');
    context
        .read<WantedTimeToWakeCubit>()
        .setTimeFirebase(times['wakeAtTime'] ?? 'Not set');
  }

  void wakeAt() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        context.read<WantedTimeToWakeCubit>().setWantedTimeToWake(value);
        context.read<DbCubit>().updateWakeTime(
            DateFormat.jm().format(DateTime.now().applied(value)));
        print(context.read<WantedTimeToWakeCubit>().state);
        ShadToaster.of(context).show(
          ShadToast(
            title: const Text('Picked The Time You Wanted Succesfully '),
            description: Text(
                'Picked time is: ${context.read<WantedTimeToWakeCubit>().state}'),
          ),
        );
      }
    });

    print(context.read<WantedTimeToWakeCubit>().state);
  }

  void sleepNow() {
    context.read<SleepNowCubit>().setSleepNowTime();
    context.read<DbCubit>().updateSleepTime(
        DateFormat.jm().format(DateTime.now().applied(TimeOfDay.now())));
  }

  void _fetchWeather() async {
    try {
      // Request permission to access location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle denied permission
        print('Location permission denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      context.read<WeatherBlocBloc>().add(FetchWeather(position));
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  @override
  void initState() {
    wantedTimeTowake = context.read<WantedTimeToWakeCubit>().state;
    updateTimes();
    _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AvatarNameAdvice(),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
            builder: (context, state) {
              if (state is WeatherBlocLoading) {
                return const CircularProgressIndicator();
              } else if (state is WeatherBlocSuccess) {
                return WeatherContainer(weather: state.weather);
              } else if (state is WeatherBlocFailure) {
                return const Text('Failed to load weather data.');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: HomeTile(
                    onTap: () {
                      sleepNow();
                      print(context.read<SleepNowCubit>().state);
                    },
                    icon: LucideIcons.bed,
                    title: 'Sleep Now',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: HomeTile(
                    onTap: () {
                      wakeAt();
                    },
                    icon: LucideIcons.sunMoon,
                    title: 'Wake at',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: HomeTile(
                    onTap: () {
                      openUrl();
                    },
                    icon: LucideIcons.listCollapse,
                    title: 'About Sleep \n Cycles',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

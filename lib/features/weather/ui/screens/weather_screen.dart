// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:sleep_manager/features/home/ui/screens/home_screen.dart';
// import 'package:sleep_manager/features/weather/logic/bloc/weather_bloc.dart';

// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({Key? key}) : super(key: key);

//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   Widget getWeatherIcon(int code) {
//     switch (code) {
//       case >= 200 && < 300:
//         return Image.asset('assets/1.png');
//       case >= 300 && < 400:
//         return Image.asset('assets/2.png');
//       case >= 500 && < 600:
//         return Image.asset('assets/3.png');
//       case >= 600 && < 700:
//         return Image.asset('assets/4.png');
//       case >= 700 && < 800:
//         return Image.asset('assets/5.png');
//       case == 800:
//         return Image.asset('assets/6.png');
//       case > 800 && <= 804:
//         return Image.asset('assets/7.png');
//       default:
//         return Image.asset('assets/7.png');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _determinePosition(),
//       builder: (context, snap) {
//         if (snap.hasData) {
//           return BlocProvider<WeatherBlocBloc>(
//             create: (context) =>
//                 WeatherBlocBloc()..add(FetchWeather(snap.data as Position)),
//             child: FutureBuilder(
//               future: _determinePosition(),
//               builder: (context, snap) {
//                 if (snap.hasData) {
//                   return BlocProvider<WeatherBlocBloc>(
//                     create: (context) => WeatherBlocBloc()
//                       ..add(FetchWeather(snap.data as Position)),
//                     child: SingleChildScrollView(
//                       child: Stack(
//                         children: [
//                           Align(
//                             alignment: const AlignmentDirectional(3, -0.3),
//                             child: Container(
//                               height: 300,
//                               width: 300,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: const AlignmentDirectional(-3, -0.3),
//                             child: Container(
//                               height: 300,
//                               width: 300,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color(0xFF673AB7),
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: const AlignmentDirectional(0, -1.2),
//                             child: Container(
//                               height: 300,
//                               width: 600,
//                               decoration: const BoxDecoration(
//                                 color: Color.fromARGB(255, 255, 64, 64),
//                               ),
//                             ),
//                           ),
//                           BackdropFilter(
//                             filter:
//                                 ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                 color: Colors.transparent,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16),
//                             child:
//                                 BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
//                               builder: (context, state) {
//                                 if (state is WeatherBlocSuccess) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           '📍 ${state.weather.areaName}',
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       const Text(
//                                         'Good Morning',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 25,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       getWeatherIcon(
//                                           state.weather.weatherConditionCode!),
//                                       Center(
//                                         child: Text(
//                                           '${state.weather.temperature!.celsius!.round()}°C',
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 55,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                       Center(
//                                         child: Text(
//                                           state.weather.weatherMain!
//                                               .toUpperCase(),
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 25,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Center(
//                                         child: Text(
//                                           DateFormat('EEEE dd •')
//                                               .add_jm()
//                                               .format(state.weather.date!),
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w300,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 30),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Image.asset(
//                                                 'assets/11.png',
//                                                 scale: 8,
//                                               ),
//                                               const SizedBox(width: 5),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text(
//                                                     'Sunrise',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 3),
//                                                   Text(
//                                                     DateFormat()
//                                                         .add_jm()
//                                                         .format(state
//                                                             .weather.sunrise!),
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Image.asset(
//                                                 'assets/12.png',
//                                                 scale: 8,
//                                               ),
//                                               const SizedBox(width: 5),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text(
//                                                     'Sunset',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 3),
//                                                   Text(
//                                                     DateFormat()
//                                                         .add_jm()
//                                                         .format(state
//                                                             .weather.sunset!),
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Image.asset(
//                                                 'assets/13.png',
//                                                 scale: 8,
//                                               ),
//                                               const SizedBox(width: 5),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text(
//                                                     'Temp Max',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 3),
//                                                   Text(
//                                                     "${state.weather.tempMax!.celsius!.round()} °C",
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Image.asset(
//                                                 'assets/14.png',
//                                                 scale: 8,
//                                               ),
//                                               const SizedBox(width: 5),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Text(
//                                                     'Temp Min',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w300,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 3),
//                                                   Text(
//                                                     "${state.weather.tempMin!.celsius!.round()} °C",
//                                                     style: const TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 } else {
//                                   return Container();
//                                 }
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 } else {
//                   return const Scaffold(
//                     body: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//               },
//             ),
//           );
//         } else {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled, request to enable it.
//     bool serviceEnabled = await Geolocator.openLocationSettings();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   return await Geolocator.getCurrentPosition();
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sleep_manager/features/weather/logic/services/location_service.dart';
import 'package:sleep_manager/features/weather/ui/widgets/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocationService.determinePosition(),
      builder: (context, snap) {
        if (snap.hasData) {
          return SafeArea(
              child: WeatherWidget(position: snap.data as Position));
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

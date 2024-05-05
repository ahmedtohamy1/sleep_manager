import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/ui/screens/home.dart';
import 'package:sleep_manager/features/profile/ui/screens/profile_screen.dart';
import 'package:sleep_manager/features/weather/ui/screens/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const Home(),
    const WeatherScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.home,
                size: 35,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.cloudFog,
                size: 30,
              ),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LucideIcons.circleUser,
                size: 30,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: SafeArea(child: screens[currentIndex]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskyapp/Screens/completed_tasks_screen.dart';
import 'package:taskyapp/Screens/profile_screen.dart';
import 'package:taskyapp/Screens/tasks_Screen.dart';
import 'package:taskyapp/features/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/home.svg', 0),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/toDo.svg', 1),

            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/completed.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/images/profile.svg', 3),

            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screens[currentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) => SvgPicture.asset(
    path,
    colorFilter: ColorFilter.mode(
      currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
      BlendMode.srcIn,
    ),
  );
}

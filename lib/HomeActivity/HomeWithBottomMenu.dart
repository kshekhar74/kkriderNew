import 'package:flutter/material.dart';
import '../core/SharedPrefHelper.dart';
import 'HomeTab/HomeScreen.dart';
import 'LeadsTab/LeadsView.dart';
import 'ProfileTab/ProfileView.dart';
import 'ReportsTab/ReportsView.dart';

class HomeWithBottomMenu extends StatefulWidget {
  const HomeWithBottomMenu({super.key});

  @override
  State<HomeWithBottomMenu> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeWithBottomMenu> {
  int _currentIndex = 0;
  int? userId;

  final List<Widget> _screens = [
    HomeScreen(),
    LeadsView(),
    ReportsView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    int? id = await SharedPrefHelper.getUserId();
    setState(() {
      userId = id;
    });

    // Optional: Print or use userId for debugging
    print("Loaded User ID: $userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard_sharp), label: "Leads"),
            BottomNavigationBarItem(icon: Icon(Icons.event_repeat_outlined), label: "Reports"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

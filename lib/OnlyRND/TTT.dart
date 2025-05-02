import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const KisanKonnectApp());
}

class KisanKonnectApp extends StatelessWidget {
  const KisanKonnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KisanKonnect Recruiter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SF Pro'),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  Widget _buildOptionTile(IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF00B050)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=3'), // sample image
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rider Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('98388 89898',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF00B050)),
                    onPressed: () {},
                  )
                ],
              ),
            ),

            // Option List
            _buildOptionTile(Icons.badge, 'ID Card'),
            _buildOptionTile(Icons.work_outline_rounded, 'Current Job Opening'),
            _buildOptionTile(Icons.group_outlined, 'Recent Leads'),
            _buildOptionTile(Icons.location_city, 'Location KFH/DC'),
            _buildOptionTile(Icons.notifications_none_rounded, 'Notification'),
            _buildOptionTile(Icons.phone_in_talk_outlined, 'Contact TL'),
            _buildOptionTile(Icons.logout, 'Logout'),

            const SizedBox(height: 12),

            // Footer
            const Text(
              'KisanKonnect Field Recruiter',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              'App version 0.0.110',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00B050),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_2_fill), label: 'Leads'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_text_fill), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle_fill),
              label: 'Profile'),
        ],
      ),
    );
  }
}

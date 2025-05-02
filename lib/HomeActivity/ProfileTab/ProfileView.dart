import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

/// Riverpod provider for bottom navigation index

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:  Text('Profile', style:  GoogleFonts.figtree(color: Colors.black, fontSize: 16,
          fontWeight: FontWeight.bold,),),
        centerTitle: false, // Align title to the left
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false, // Remove default back button if needed
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
                   Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rider Name',
                            style: GoogleFonts.figtree(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('98388 89898',
                            style: GoogleFonts.figtree(color: Colors.grey)),
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
             Text(
              'KisanKonnect Field Recruiter',
              style: GoogleFonts.figtree(color: Colors.grey),
            ),
             Text(
              'App version 0.0.110',
              style: GoogleFonts.figtree(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF00B050)),
        ),
        title: Text(title, style:  GoogleFonts.figtree(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        onTap: () {},
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../OnlyRND/ProductListScreen.dart';
import '../LeadsTab/LeadsView.dart';
import '../rnd/Lead/RiderLeadView.dart';
import '../rnd/RiderStatus/RiderStatusView.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_HomeButton> buttons = [
      _HomeButton(icon: Icons.landslide_sharp, label: 'Rider Lead', onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RiderLeadView()),
        );

      }),
      _HomeButton(icon: Icons.local_shipping, label: 'Rider Status', onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RiderStatusView()),
        );

      }),
      _HomeButton(icon: Icons.no_food, label: 'Rider FOD', onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LeadsView()),
        );
      }),
      _HomeButton(icon: Icons.no_food, label: 'RND', onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) =>  ProductListScreen()),
        );
      }),

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',  style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'philosopher',
          color: Colors.white,
        ),),
        backgroundColor: Colors.green[800],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: buttons.map((button) => button.build()).toList(),
        ),
      ),
    );
  }
}

class _HomeButton {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  Widget build() {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.green[800]),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'philosopher',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

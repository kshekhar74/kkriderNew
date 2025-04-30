import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../OnlyRND/ProductListScreen.dart';
import '../LeadsTab/LeadsView.dart';
import '../rnd/Lead/RiderLeadView.dart';
import '../rnd/RiderStatus/RiderStatusView.dart';

final onlineStatusProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<String> options = [
    'All Leads',
    'Registered',
    'FOD',
    '10 orders',
    '20 orders',
    '30 orders',
    '50 orders',
    'Failed',
  ];

  String selectedOption = 'All Leads';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(onlineStatusProvider);


    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                _onlineToggleCard(isOnline, ref),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome, Recruiter',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text('Manage your recruitment process',
                          style: TextStyle(fontSize: 13, color: Colors.black54)),
                      const SizedBox(height: 10),
                      _hiringCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Performance Dashboard',
                          style: GoogleFonts.figtree(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          )),
                      Row(
                        children: [
                          _buildIconButton(context, Icons.filter_alt_outlined, 1),
                          const SizedBox(width: 10),
                          _buildIconButton(context, Icons.calendar_today_outlined, 2),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.6,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildStatCard(Icons.group, '2,456', 'Active Leads'),
                      _buildStatCard(Icons.shopping_cart, '2,456', 'Registrations'),
                      _buildStatCard(Icons.local_shipping, '24%', 'Conversion'),
                      _buildStatCard(Icons.person_add_alt, '456', 'First Order Delivery'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      padding:  EdgeInsets.all(10),
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.green, size: 30),
              Text(count, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            ],
          ),

    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, int temp) {
    return InkWell(
      onTap: () {
        if (temp == 1) {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          child: const Text(
                            'Select your preferred filter',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return RadioListTile<String>(
                              title: Text(options[index]),
                              value: options[index],
                              groupValue: selectedOption,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() => selectedOption = value!);
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                Navigator.pop(context, selectedOption);
                              },
                              child: const Text('Done', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Date Filter'),
              content: const Text('Implement date filter logic here.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
              ],
            ),
          );
        }
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.green, size: 18),
      ),
    );
  }

  Widget _onlineToggleCard(bool isOnline, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isOnline
              ? [Colors.green.shade600, Colors.green.shade300]
              : [Colors.grey.shade600, Colors.grey.shade400],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(isOnline ? Icons.wifi : Icons.wifi_off, color: Colors.white),
          const SizedBox(width: 7),
          Text(
            isOnline ? "Online" : "Offline",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Switch(
            value: isOnline,
            onChanged: (value) {
              ref.read(onlineStatusProvider.notifier).state = value;
            },
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _hiringCard() {
    final List<String> imageList = [
      'https://picsum.photos/800/400?img=1',
      'https://picsum.photos/800/400?img=2',
      'https://picsum.photos/800/400?img=3',
    ];
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        viewportFraction: 0.8,
      ),
      items: imageList.map((item) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF00A86B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("We're Hiring!",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Looking for delivery partners in your area.',
                  style: TextStyle(color: Colors.white70)),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF00A86B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('View Details'),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void showOfflineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("You're Offline"),
        content: const Text("Please go online to access this feature."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

class HomeButton {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  HomeButton({required this.icon, required this.label, required this.onTap});

  Widget build() {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: Colors.green[700]),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.philosopher(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

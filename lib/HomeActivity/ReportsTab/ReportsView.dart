import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../rnd/Lead/ApiServiceLead.dart';
import '../rnd/Lead/VehicleResponse.dart';

final apiServiceProvider = Provider<ApiServiceLead>((ref) => ApiServiceLead());

final vehicleTypeProvider = FutureProvider<VehicleResponse>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchVehicleTypes();
});

class ReportsView extends ConsumerWidget {
  ReportsView({super.key});

  final List<Map<String, dynamic>> sourceData = [
    {
      'source': 'Field recruiters',
      '<10': 100,
      '10th': 123,
      '20th': 243,
      '30th': 324,
    },
    {'source': 'Connectors', '<10': 100, '10th': 324, '20th': 234, '30th': 234},
    {'source': 'Vendors', '<10': 100, '10th': 424, '20th': 242, '30th': 785},
    {'source': 'Referrals', '<10': 100, '10th': 234, '20th': 234, '30th': 456},
  ];

  String selectedOption = 'All Leads';

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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'philosopher',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Performance Dashboard',
                  style: GoogleFonts.figtree(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    _buildIconButton(context,Icons.filter_alt_outlined,1),
                    const SizedBox(width: 10),
                    _buildIconButton(context,Icons.calendar_today_outlined,2),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard(Icons.group, '2,456', 'Total Leads'),
                _buildStatCard(Icons.shopping_cart, '2,456', 'Total Orders'),
                _buildStatCard(Icons.local_shipping, '2,456', 'First Order'),
                _buildStatCard(Icons.person_add_alt, '2,456', 'New Registration',
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: sourceData.length + 1, // +1 for Header
              itemBuilder: (context, index) {
                if (index == 0) {
                  // HEADER ROW
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300, // header background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Source',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '<10',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '10th',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '20th',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '30th',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // List Data Rows
                  final item =
                      sourceData[index - 1]; // -1 because 0th is header
                  final bool isEvenRow = (index % 2 == 0); // even index -> true
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isEvenRow ? Colors.grey.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(item['source'] ?? '')),
                        Expanded(child: Text('${item['<10']}')),
                        Expanded(child: Text('${item['10th']}')),
                        Expanded(child: Text('${item['20th']}')),
                        Expanded(child: Text('${item['30th']}')),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, int temp) {
    return InkWell(
      onTap: () {
        if (temp == 1) {
          // Show a custom bottom sheet or modal
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
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
        } else {
          // Handle the other case for temp != 1
          // You can show a different modal or container here
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Different Case for Temp != 1'),
                content: Text('Handle temp != 1 logic here.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
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


  Widget _buildStatCard(IconData icon, String number, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Colors.green),
          Text(
            number,
            style: GoogleFonts.figtree(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.figtree(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

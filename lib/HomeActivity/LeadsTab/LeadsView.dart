import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../OnlyRND/rnd/Lead/ApiServiceLead.dart';
import '../../OnlyRND/rnd/Lead/VehicleResponse.dart';
import 'details/RiderDetailsScreen.dart';

final apiServiceProvider = Provider<ApiServiceLead>((ref) => ApiServiceLead());

final vehicleTypeProvider = FutureProvider<VehicleResponse>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchVehicleTypes();
});

class LeadsView extends ConsumerWidget {
  LeadsView({super.key});

  final leads = [
    {
      'name': 'Madhu Kaimal',
      'statusBadge': 'Registered',
      'statusColor': Colors.orange,
      'mobile': '+91 98883 78787',
      'currentStatus': 'Student',
      'area': 'Nerul, Navi-Mumbai',
      'position': 'Connectors',
      'remarks': 'Completed initial training session',
    },
    {
      'name': 'Prathamesh Chavan',
      'statusBadge': 'FOD',
      'statusColor': Colors.green,
      'mobile': '+91 98883 78787',
      'currentStatus': 'Student',
      'area': 'Nerul, Navi-Mumbai',
      'position': 'Rider',
      'remarks': 'Completed initial training session',
    },
    {
      'name': 'Prathamesh Chavan',
      'statusBadge': 'Failed',
      'statusColor': Colors.red,
      'mobile': '+91 98883 78787',
      'currentStatus': 'Student',
      'area': 'Nerul, Navi-Mumbai',
      'position': 'Rider',
      'remarks': 'Completed initial training session',
    },
    {
      'name': 'Prathamesh Chavan',
      'statusBadge': 'FOD',
      'statusColor': Colors.green,
      'mobile': '+91 98883 78787',
      'currentStatus': 'Student',
      'area': 'Nerul, Navi-Mumbai',
      'position': 'Rider',
      'remarks': 'Completed initial training session',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title:  Text('All Leads', style:  GoogleFonts.figtree(color: Colors.black, fontSize: 16,
          fontWeight: FontWeight.bold,),),
        centerTitle: false, // Align title to the left
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false, // Remove default back button if needed
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: leads.length,
        itemBuilder: (context, index) {
          final lead = leads[index];
          final String name = lead['name'] as String;
          final String badge = lead['statusBadge'] as String;
          final Color color = lead['statusColor'] as Color;
          final String mobile = lead['mobile'] as String;
          final String currentStatus = lead['currentStatus'] as String;
          final String area = lead['area'] as String;
          final String position = lead['position'] as String;
          final String remarks = lead['remarks'] as String;

          return InkWell(
            onTap: () {
              // Example action: Navigate to RiderDetailsScreen or show dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RiderDetailsScreen(leadData: lead),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Name + Badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style:  GoogleFonts.figtree(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            badge,
                            style: GoogleFonts.figtree(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Mobile & Status
                    Row(
                      children: [
                        Expanded(child: _buildInfoRow('Mobile No', mobile)),
                        Expanded(child: _buildInfoRow('Current Status', currentStatus)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Area & Position
                    Row(
                      children: [
                        Expanded(child: _buildInfoRow('Area', area)),
                        Expanded(child: _buildInfoRow('Position', position)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Remarks
                    _buildInfoRow('Remarks', remarks),
                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style:  GoogleFonts.figtree(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(
              text: '$label\n',
              style:  GoogleFonts.figtree(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: value,
              style:  GoogleFonts.figtree(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

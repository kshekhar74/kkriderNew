import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderDetailsScreen extends ConsumerWidget {
  final Map<String, dynamic> leadData;

  const RiderDetailsScreen({super.key, required this.leadData});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title:  Text('Rider Details',style: GoogleFonts.figtree(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, bottom: 60,right: 10),

        child: Column(
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 12),
            _buildStatusCard(
              title: 'Registration Status',
              status: leadData['registrationStatus'] ?? 'Unknown',
              statusColor: Colors.green,
              dateTitele: 'Date',
              date: leadData['registrationDate'] ?? 'N/A',
            ),
            const SizedBox(height: 12),
            _buildFirstOrderCard(),
            const SizedBox(height: 12),
            _buildOrderCountCard(),
            const SizedBox(height: 12),
            _buildRemarksCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 8),
            Text(
              leadData['name'] ?? 'No Name',
              style:  GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const Divider(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoColumn(
                  title: 'Mobile No',
                  value: leadData['mobile'] ?? 'N/A',
                ),
                _InfoColumn(
                  title: 'Current Status',
                  value: leadData['currentStatus'] ?? 'N/A',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoColumn(
                  title: 'Area',
                  value: leadData['area'] ?? 'N/A',
                ),
                _InfoColumn(
                  title: 'Position',
                  value: leadData['position'] ?? 'N/A',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String status,
    required Color statusColor,
    required String dateTitele,
    required String date,
  }) {
    return _RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('Registration Status',
              style: GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 12),
          _InfoRow(label: 'Status', value: 'Registered', color: Colors.green),
          SizedBox(height: 6),
          _InfoRow(label: 'Date', value: 'Jan 15, 2024'),

        ],
      ),
    );
  }

  Widget _buildFirstOrderCard() {
    return _RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('First Order Details',
              style: GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 12),
          _InfoRow(label: 'Status', value: 'Completed', color: Colors.green),
          SizedBox(height: 6),
          _InfoRow(label: 'Date', value: 'Jan 16, 2024'),
          SizedBox(height: 6),
          _InfoRow(label: 'Order Number', value: '#12345'),
        ],
      ),
    );
  }

  Widget _buildOrderCountCard() {
    return _RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('Order Count',
              style: GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 12),
          _InfoRow(label: 'Day 1', value: '3 orders'),
          _InfoRow(label: 'Day 2', value: '5 orders'),
          _InfoRow(label: 'Day 3', value: '1 order'),
        ],
      ),
    );
  }


  Widget _buildRemarksCard() {
    final List<Map<String, String>> remarksList = [
      {
        'time': leadData['remarksTime1'] ?? '2 hours ago',
        'text': leadData['remarks1'] ?? 'Completed initial training session',
      },
      {
        'time': leadData['remarksTime2'] ?? 'Jan 16, 2024',
        'text': leadData['remarks2'] ?? 'Contacted for orientation',
      },
    ];

    return _RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Remarks',
            style: GoogleFonts.figtree(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Add Remark',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          ...remarksList.map((remark) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remark['time']!,
                    style:  GoogleFonts.figtree(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                    remark['text']!,
                    style:  GoogleFonts.figtree(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }


}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:  GoogleFonts.figtree(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style:  GoogleFonts.figtree(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _InfoRow({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:  GoogleFonts.figtree(color: Colors.black54, fontSize: 13)),
        Text(value,
            style: GoogleFonts.figtree(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: color ?? Colors.black87,
            )),
      ],
    );
  }
}

class _RoundedCard extends StatelessWidget {
  final Widget child;

  const _RoundedCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

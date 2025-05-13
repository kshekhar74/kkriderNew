import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../core/SharedPrefHelper.dart';
import 'LeadService/LeadController.dart';

final onlineStatusProvider = StateProvider<bool>((ref) => false);
final riderTypeProvider = StateProvider<String>((ref) => 'Rider');
final statusProvider = StateProvider<String?>((ref) => null);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final _formKey = GlobalKey<FormState>();

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
  final List<String> imageList = [
    'https://images.unsplash.com/photo-1603574670812-d24560880210?auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=800&q=60',
  ];
  String selectedOption = 'All Leads';
  int riderTypePost =0;


// Declare controllers outside build()
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final areaController = TextEditingController();
  final remarkController = TextEditingController();



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(onlineStatusProvider);
    final riderType = ref.watch(riderTypeProvider);
    final selectedStatus = ref.watch(statusProvider);
    final isLoading = ref.watch(leadControllerProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: _onlineToggleCard(isOnline, ref),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Recruiter',
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Manage your recruitment process',
                  style: GoogleFonts.figtree(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                _hiringCard(),
                const SizedBox(height: 20),
                _performanceSection(context),
                const SizedBox(height: 10),
                Text(
                  'New Rider Lead',
                  style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 10),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: 'Mobile number*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          counterText: '',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Current Status*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        value: selectedStatus,
                        items: ['Full Time', 'Part Time']
                            .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                            .toList(),
                        onChanged: (value) {
                          ref.read(statusProvider.notifier).state = value;
                        },
                        validator: (value) =>
                        value == null ? 'Please select a status' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: areaController,
                        decoration: InputDecoration(
                          labelText: 'Area*',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RadioListTile<String>(
                                value: 'Rider',
                                groupValue: riderType,
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                title: Text('Rider',
                                    style: GoogleFonts.figtree(fontSize: 14)),
                                visualDensity: VisualDensity.compact,
                                onChanged: (value) {
                                  ref.read(riderTypeProvider.notifier).state =
                                  value!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: RadioListTile<String>(
                                value: 'Connector',
                                groupValue: riderType,
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                title: Text('Connector',
                                    style: GoogleFonts.figtree(fontSize: 14)),
                                visualDensity: VisualDensity.compact,
                                onChanged: (value) {
                                  ref.read(riderTypeProvider.notifier).state =
                                  value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: remarkController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Add Remark',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final riderName = nameController.text.trim();
                              final mobileNo = mobileController.text.trim();
                              final area = areaController.text.trim();
                              final remark = remarkController.text.trim();

                              int riderTypePost =
                              riderType == 'Rider' ? 1 : 2;

                              int? userId =
                              await SharedPrefHelper.getUserId();

                              try {
                                final result = await ref
                                    .read(leadControllerProvider.notifier)
                                    .leadRegi(
                                  riderName,
                                  mobileNo,
                                  selectedStatus!,
                                  area,
                                  riderTypePost,
                                  remark,
                                  "Active",
                                  userId!,
                                );

                                if (result.status == '200') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Lead successful!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result.msg),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Add Rider',
                            style: GoogleFonts.figtree(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isLoading) const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




  Widget _hiringCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
        ),
        items:
            imageList.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          "Hiring Campaign",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
      ),
    );
  }

  Widget _performanceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                _buildIconButton(context, Icons.filter_alt_outlined, 1),
                const SizedBox(width: 10),
                _buildIconButton(context, Icons.calendar_today_outlined, 2),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6,
          children: [
            _buildStatCard(Icons.group, '2,456', 'Active Leads'),
            _buildStatCard(Icons.shopping_cart, '2,456', 'Registrations'),
            _buildStatCard(Icons.local_shipping, '24%', 'Conversion'),
            _buildStatCard(Icons.person_add_alt, '456', 'First Order Delivery'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 30),
          Text(
            count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Select your preferred filter',
                          style: GoogleFonts.figtree(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
                            child: Text(
                              'Done',
                              style: GoogleFonts.figtree(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Date Filter'),
                  content: const Text('Implement date filter logic here.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isOnline
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
          ),
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

}

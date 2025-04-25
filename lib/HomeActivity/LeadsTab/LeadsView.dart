import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../rnd/Lead/ApiServiceLead.dart';
import '../rnd/Lead/VehicleResponse.dart';

final apiServiceProvider = Provider<ApiServiceLead>((ref) => ApiServiceLead());

final vehicleTypeProvider = FutureProvider<VehicleResponse>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchVehicleTypes();
});

class LeadsView extends ConsumerWidget {
  const LeadsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleTypeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leads',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'philosopher',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: vehicleAsync.when(
          data: (response) => ListView.builder(
            itemCount: response.vehicleTypes.length,
            itemBuilder: (context, index) {
              final vehicle = response.vehicleTypes[index];

              // Assuming vehicle model has these fields:
              // name, mobileNo, area, position, remarks, status

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Name\n${vehicle.vehicleType ?? 'N/A'}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                    /*      Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getStatusColor(vehicle.status).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              vehicle.status ?? "Unknown",
                              style: TextStyle(
                                color: _getStatusColor(vehicle.status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Details
                   /*   Row(
                        children: [
                          _buildInfoColumn("Mobile No", vehicle.mobileNo ?? 'N/A'),
                          const SizedBox(width: 32),
                          _buildInfoColumn("Current Status", vehicle.status ?? 'N/A'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildInfoColumn("Area", vehicle.area ?? 'N/A'),
                          const SizedBox(width: 32),
                          _buildInfoColumn("Position", vehicle.position ?? 'N/A'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildInfoColumn("Remarks", vehicle.remarks ?? 'N/A'),*/
                    ],
                  ),
                ),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                Text('Error: $e', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for displaying Title + Value
  Widget _buildInfoColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Method to decide badge color based on status
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      case 'completed':
      case 'success':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

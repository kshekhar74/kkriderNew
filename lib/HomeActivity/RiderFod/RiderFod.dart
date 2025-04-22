import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ApiServiceLead.dart';
import 'VehicleResponse.dart';

final apiServiceProvider = Provider<ApiServiceLead>((ref) => ApiServiceLead());

final vehicleTypeProvider = FutureProvider<VehicleResponse>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchVehicleTypes();
});


class RiderFod extends ConsumerWidget {
  const RiderFod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleAsync = ref.watch(vehicleTypeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider Fod',  style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'philosopher',
          color: Colors.white,
        ),),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: vehicleAsync.when(
          data: (response) => ListView.builder(
            itemCount: response.vehicleTypes.length,
            itemBuilder: (context, index) {
              final vehicle = response.vehicleTypes[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  leading: const Icon(
                    Icons.directions_car,
                    color: Colors.indigo,
                    size: 32,
                  ),
                  title: Text(
                    vehicle.vehicleType,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'philosopher',
                      color: Colors.black,
                    ),
                  ),
                  subtitle: const Text('Tap for details', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'philosopher',
                    color: Colors.black,
                  )),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Vehicle ID: ${response.vehicleTypes[index].id.toString()}'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.indigo,
                      ),
                    );

                  },
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
}

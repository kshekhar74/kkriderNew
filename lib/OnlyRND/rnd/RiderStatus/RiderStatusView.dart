import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../Lead/ApiServiceLead.dart';
import '../Lead/VehicleResponse.dart';

final apiServiceProvider = Provider<ApiServiceLead>((ref) => ApiServiceLead());

final filteredVehicleProvider = FutureProvider.family<VehicleResponse, Map<String, dynamic>>((ref, params) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchVehicleTypes(); // Modify this method to accept filter if needed.
});

class RiderStatusView extends ConsumerStatefulWidget {
  const RiderStatusView({super.key});

  @override
  ConsumerState<RiderStatusView> createState() => _RiderStatusViewState();
}

class _RiderStatusViewState extends ConsumerState<RiderStatusView> {
  String? selectedType;
  DateTime? selectedDate;
  bool showResult = false;

  Map<String, dynamic> get _filters => {
    'type': selectedType,
    'date': selectedDate,
  };

  @override
  Widget build(BuildContext context) {
    final vehicleAsync = showResult
        ? ref.watch(filteredVehicleProvider(_filters))
        : null;

    return Scaffold(
      appBar:AppBar(
        title: const Text('Rider Status',  style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'philosopher',
          color: Colors.white,
        ),),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Dropdown & Date Picker Card
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  // Dropdown
                  FutureBuilder<VehicleResponse>(
                    future: ref.read(apiServiceProvider).fetchVehicleTypes(),
                    builder: (context, snapshot) {
                      final types = snapshot.data?.vehicleTypes
                          .map((e) => e.vehicleType)
                          .toSet()
                          .toList() ??
                          [];

                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Vehicle Type',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedType,
                        items: types.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // Date Picker
                  InkWell(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        selectedDate == null
                            ? 'Select Date'
                            : DateFormat('dd MMM yyyy').format(selectedDate!),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Filter Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.filter_alt),
                      label: const Text('Apply Filter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (selectedType == null || selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                selectedType == null && selectedDate == null
                                    ? 'Please select a vehicle type and a date'
                                    : selectedType == null
                                    ? 'Please select a vehicle type'
                                    : 'Please select a date',
                              ),
                              backgroundColor: Colors.grey,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          setState(() {
                            showResult = true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // List View with Filtered Data
            if (showResult)
              Expanded(
                child: vehicleAsync!.when(
                  data: (response) {
                    final filteredList = response.vehicleTypes.where((vehicle) {
                      final matchesType = selectedType == null || vehicle.vehicleType == selectedType;
                      return matchesType;
                    }).toList();

                    if (filteredList.isEmpty) {
                      return const Center(child: Text('No vehicles found.'));
                    }

                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final vehicle = filteredList[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            leading: const Icon(Icons.directions_car, color: Colors.indigo, size: 32),
                            title: Text(
                              vehicle.vehicleType,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'philosopher',
                                color: Colors.black,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Vehicle ID: ${vehicle.id}'),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.indigo,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              )
          ],
        ),
      ),
    );
  }
}

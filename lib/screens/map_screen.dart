import 'package:flutter/material.dart';
import '../models/powerbank.dart';
import 'reservation_success_screen.dart';

class MapScreen extends StatefulWidget {
  final List<PowerBank>? powerBanks;

  const MapScreen({super.key, this.powerBanks});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<PowerBank> _powerBanks;

  @override
  void initState() {
    super.initState();
    _powerBanks = widget.powerBanks ??
        [
          PowerBank(
            id: '#102',
            batteryPercent: 85,
            stationName: 'Station #5',
            status: PowerBankStatus.available,
          ),
          PowerBank(
            id: '#205',
            batteryPercent: 42,
            stationName: 'Station #3',
            status: PowerBankStatus.available,
          ),
          PowerBank(
            id: '#078',
            batteryPercent: 90,
            stationName: 'Station #1',
            status: PowerBankStatus.reserved,
          ),
        ];
  }

  void _onReservePressed(int index) {
    final pb = _powerBanks[index];

    if (pb.status == PowerBankStatus.reserved) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          key: const Key('unavailableDialog'),
          icon: const Icon(Icons.error_outline, color: Colors.red, size: 48),
          title: const Text('PowerBank Unavailable'),
          content: const Text(
            'This PowerBank has already been reserved by another user.\n'
            'Please choose another station.',
          ),
          actions: [
            TextButton(
              key: const Key('findAnotherButton'),
              onPressed: () => Navigator.pop(context),
              child: const Text('Find Another PowerBank'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      pb.status = PowerBankStatus.reserved;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReservationSuccessScreen(
          powerBank: pb,
          onReservationExpired: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PowerUP')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              key: const Key('mapArea'),
              width: double.infinity,
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 56, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Map View',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _powerBanks.length,
              itemBuilder: (context, index) {
                final pb = _powerBanks[index];
                final isAvailable = pb.status == PowerBankStatus.available;

                return Card(
                  key: Key('powerbank_$index'),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PowerBank ${pb.id}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pb.stationName,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.battery_charging_full, size: 18),
                            const SizedBox(width: 4),
                            Text('Battery: ${pb.batteryPercent}%'),
                            const SizedBox(width: 16),
                            Icon(
                              isAvailable ? Icons.check_circle : Icons.cancel,
                              size: 18,
                              color: isAvailable ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Status: ${isAvailable ? "Available" : "Reserved"}',
                              style: TextStyle(
                                color: isAvailable ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: Key('reserveButton_$index'),
                            onPressed: () => _onReservePressed(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAvailable
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              isAvailable
                                  ? 'Reserve PowerBank'
                                  : 'Already Reserved',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
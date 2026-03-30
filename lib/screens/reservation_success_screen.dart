import 'dart:async';
import 'package:flutter/material.dart';
import '../models/powerbank.dart';

class ReservationSuccessScreen extends StatefulWidget {
  final PowerBank powerBank;
  final Duration reservationDuration;
  final VoidCallback? onReservationExpired;

  const ReservationSuccessScreen({
    super.key,
    required this.powerBank,
    this.reservationDuration = const Duration(minutes: 10),
    this.onReservationExpired,
  });

  @override
  State<ReservationSuccessScreen> createState() =>
      _ReservationSuccessScreenState();
}

class _ReservationSuccessScreenState
    extends State<ReservationSuccessScreen> {
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.reservationDuration.inSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        widget.powerBank.status = PowerBankStatus.available;
        widget.onReservationExpired?.call();

        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  String get formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Reservation Confirmed')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: cs.primary),
              const SizedBox(height: 16),
              const Text(
                'PowerBank Reserved!',
                key: Key('reservationSuccessTitle'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'PowerBank ${widget.powerBank.id}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                widget.powerBank.stationName,
                style: TextStyle(
                  fontSize: 16,
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Reservation Timer',
                      key: const Key('reservationTimer'),
                      style: TextStyle(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formattedTime,
                      key: const Key('timerValue'),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pick up your PowerBank before the timer expires',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onPrimaryContainer.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
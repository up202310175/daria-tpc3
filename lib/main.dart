import 'package:flutter/material.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const PowerUpApp());
}

class PowerUpApp extends StatelessWidget {
  const PowerUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PowerUP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4CAF50),
        useMaterial3: true,
      ),
      home: const MapScreen(),
    );
  }
}

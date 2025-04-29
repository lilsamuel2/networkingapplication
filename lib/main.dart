import 'package:flutter/material.dart';
import 'package:networking_app/features/compass/presentation/compass_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompassScreen(),
    );
  }
}
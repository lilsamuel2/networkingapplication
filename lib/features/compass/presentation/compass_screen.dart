import 'dart:math';

import 'package:networking_app/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:networking_app/widgets/compass_view.dart';
import 'package:networking_app/core/app_colors.dart';

import '../../../widgets/profile_preview.dart';
import '../../../models/user_location.dart';

//make the widget a stateful widget
class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}
//add the state for the widget
class _CompassScreenState extends State<CompassScreen> {
  Position? currentPosition;
  bool isNetworkingModeOn = false; 
  String? selectedUserId;

  final Map<String, UserProfile> _userProfiles = {};

  late final List<UserLocation> _nearbyUsers = List.generate(
    5,
    (index) {
      final id = (index + 1).toString();
      final randomLat = Random().nextDouble() * 2 - 1;
      final randomLong = Random().nextDouble() * 2 - 1;
        _userProfiles[id] = UserProfile(
        id: id,
        name: 'User $id', 
        role: 'Role $id',
        linkedinUrl: 'linkedin.com/user$id',
      );
      return UserLocation(id: id, latitude: randomLat, longitude: randomLong);
    },
  ];
  


  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      print('permission granted');
      _getCurrentLocation();
    } else {
      print('permission denied');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high); 
      setState(() {
        currentPosition = position;
      });
      print(
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lat = currentPosition?.latitude ?? 0.0;
    final long = currentPosition?.longitude ?? 0.0;
    final pos =
        currentPosition != null ? 'Lat: $lat, Long: $long' : 'No Position yet';
    if (!isNetworkingModeOn) {
      currentPosition = null;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedUserId = null;
        });
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            CompassView(
              userProfiles: _userProfiles,
              isNetworkingModeOn: isNetworkingModeOn,
              nearbyUsers: _nearbyUsers, 
              onUserTap: (userId) {
                setState(() {
                  selectedUserId = userId;
                });
              },
            ),
            if (selectedUserId != null)
              ProfilePreview(
                userProfile: _userProfiles[selectedUserId!]!,
              ),
          ],
        ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isNetworkingModeOn = !isNetworkingModeOn;
            if (isNetworkingModeOn) {
              _requestLocationPermission(); 
            } else {
              setState(() {
              }); 
            }
          });
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isNetworkingModeOn ? Icons.wifi : Icons.wifi_off,
            key: ValueKey<bool>(isNetworkingModeOn),
          ),
        ),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20), 
        child: Text(pos, style: const TextStyle(fontSize: 16)),
      ),
      ),
    );
  }
}

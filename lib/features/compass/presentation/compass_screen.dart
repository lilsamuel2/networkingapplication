import 'dart:math';

import 'package:flutter/material.dart';
import 'package:networking_app/features/profile/profile_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:networking_app/core/app_colors.dart';
import 'package:networking_app/widgets/compass_view.dart';
import 'package:networking_app/models/user_location.dart';
import 'package:networking_app/models/user_profile.dart';


class CompassScreen extends StatefulWidget {
  final Function() onProfileTap;
  const CompassScreen({super.key, required this.onProfileTap});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

//add the state for the widget
class _CompassScreenState extends State<CompassScreen> {
  Position? _currentPosition;

  bool isNetworkingModeOn = false;  

  final Map<String, UserProfile> _userProfiles = {};
  late final List<UserLocation> _nearbyUsers = List.generate(
    5, (index) {
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
  );

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();    

    if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      // Handle error
    }
  }


  @override
  Widget build(BuildContext context) {
    final lat = _currentPosition?.latitude ?? 0.0;
    final long = _currentPosition?.longitude ?? 0.0;
    final pos = _currentPosition != null ? 'Lat: $lat, Long: $long' : 'No Position yet';
    return Scaffold(body: Container(decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightBlue, AppColors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CompassView(
              userProfiles: _userProfiles,
              isNetworkingModeOn: isNetworkingModeOn,
              nearbyUsers: _nearbyUsers,
              onUserTap: (userProfile) {
                Navigator.of(context, rootNavigator: true).push(
                  

                  MaterialPageRoute(builder: (context) => ProfileScreen(userProfile: userProfile,),),
                );
              },
            ),
          ],
          ),
        ),
      ),floatingActionButton: FloatingActionButton(
        onPressed: () {

          setState(() {
            isNetworkingModeOn = !isNetworkingModeOn;
            if (isNetworkingModeOn) {
              _requestLocationPermission(); 
            }  else {
              setState(() {
              }); 
              
            }
          });
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),transitionBuilder: (Widget child, Animation<double> animation) {
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
        child: Text(pos, style: const TextStyle(fontSize: 16, color: AppColors.white))
      ),
    );
  }
}

import 'package:networking_app/core/app_colors.dart';
import 'package:networking_app/models/user_location.dart';
import 'package:networking_app/models/user_profile.dart';
import 'package:networking_app/utils/location_utils.dart';
import 'package:networking_app/widgets/compass_user_avatar.dart';
import 'dart:math';

import 'package:flutter/material.dart';
class CompassView extends StatefulWidget {
  final Map<String, UserProfile> userProfiles;
  final bool isNetworkingModeOn;
  final List<UserLocation> nearbyUsers;
  final Function(UserProfile) onUserTap;
  final GlobalKey<NavigatorState> navigatorKey;

  const CompassView({
    super.key,
    required this.isNetworkingModeOn,
    required this.nearbyUsers,
    required this.userProfiles,
    required this.onUserTap,
    required this.navigatorKey,
  });

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> with SingleTickerProviderStateMixin {
  bool _showProfile = false;
  @override
  void initState() {
    super.initState();
  }

  Widget _buildUserDot(UserLocation user, UserLocation center) {
    Offset? offset = LocationUtils.calculatePosition(
      centerLatitude: center.latitude,
      centerLongitude: center.longitude,
      targetLatitude: user.latitude,
      targetLongitude: user.longitude, 
    );
    final userProfile = widget.userProfiles[user.id];
    if (userProfile == null){
       return const SizedBox.shrink();
    }

     if (offset == null) {
      return const SizedBox.shrink();
     }

    return Positioned(
      left: 80 + offset.dx,
      top: 80 + offset.dy,
      child: CompassUserAvatar(
        userProfile: userProfile,
        ),
    );
  }


  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              key: ValueKey<bool>(widget.isNetworkingModeOn),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: AppColors.lightBlue,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                  )
                ],
              ),
              child: Stack(children: [
                ...widget.nearbyUsers.map((user) => _buildUserDot(user,
                    UserLocation(latitude: 0, longitude: 0, id: "center"))),
                Center(
                  child: Text(
                    widget.isNetworkingModeOn ? "Networking mode ON" : "Networking mode OFF",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.black),
                  ),
                    ),
              ])),
        ),
      ),
    );
  }
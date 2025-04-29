import 'package:flutter/material.dart';
import 'package:networking_app/widgets/profile_preview.dart';
import 'package:networking_app/models/user_profile.dart';
import 'package:networking_app/models/user_location.dart';
import 'package:networking_app/core/app_colors.dart';
import 'package:networking_app/utils/location_utils.dart';
import 'dart:math';


class CompassView extends StatefulWidget {
  final Map<String, UserProfile> userProfiles;
  final bool isNetworkingModeOn ;
  final List<UserLocation> nearbyUsers;
  final Function(UserProfile) onUserTap;
  const CompassView({
    super.key,
    required this.isNetworkingModeOn,
    required this.nearbyUsers,
    required this.userProfiles,
    required this.onUserTap,
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
      left: 100  + offset.dx,
      top: 100 + offset.dy,

      child: GestureDetector(
        onTap: () => widget.onUserTap(userProfile),
        child: Container(
        width: 50,
        height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: AppColors.white,
                width: 2,
              )),
          child: Center(
            child: Text(
              userProfile.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
        child: Container(
            key: ValueKey<bool>(widget.isNetworkingModeOn),
            width: 200,
            height: 200,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              ),
              child: Stack(
                children: [
                  ...widget.nearbyUsers.map((user) => _buildUserDot(
                      user,
                      UserLocation(latitude: 0, longitude: 0, id: "center"))),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.isNetworkingModeOn
                            ? "Networking mode ON"
                            : "Networking mode OFF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  if (_showProfile)
                   GestureDetector(
                    onTap: (){
                      setState(() {
                       _showProfile = false;
                      });
                    },
                    child: Center(
                      child: ProfilePreview(),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
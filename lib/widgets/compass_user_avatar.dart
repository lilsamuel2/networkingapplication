import 'package:flutter/material.dart';
import 'package:networking_app/core/app_colors.dart';
import 'package:networking_app/features/profile/profile_screen.dart';
import 'package:networking_app/models/user_profile.dart';

class CompassUserAvatar extends StatelessWidget {
  final UserProfile userProfile;
  final GlobalKey<NavigatorState> navigatorKey;
  final void Function(UserProfile) onUserTap;
  
  const CompassUserAvatar({
    super.key,
    required this.userProfile,
    required this.onTap,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {onUserTap(userProfile);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightBlue),
        ),
          child: Center(
          child: Text(
            userProfile.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
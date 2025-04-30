
import 'package:flutter/material.dart';
import 'package:networking_app/core/app_colors.dart';
import 'package:networking_app/features/compass/presentation/compass_screen.dart';
import 'package:networking_app/features/profile/profile_screen.dart';
import 'package:networking_app/models/user_profile.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController>  {
  final UserProfile _userProfile = UserProfile(
    id: 'default',
    name: 'Default User',
    role: 'Default Role',
    linkedinUrl: 'https://www.linkedin.com/in/default-user/',
    bio: 'This is the default user bio.',
    links: [],
  );


  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  late final List<Widget> _screens = [
    Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return CompassScreen(
              onProfileTap: () {
                _onItemTapped(1);
              },
            );
          },
      },
    ),
     ProfileScreen(
      args: ProfileScreenArgs(userProfile: _userProfile),
    ),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blue,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.explore,
            ),
            label: 'Compass',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person,
                color: _selectedIndex == 1 ? AppColors.white : AppColors.white),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: AppColors.white),
        unselectedLabelStyle: const TextStyle(color: AppColors.white),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
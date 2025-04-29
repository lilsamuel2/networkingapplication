class UserLocation {
  final double latitude;
  final double longitude;
  final String id;

  UserLocation({
    required this.latitude,
    required this.longitude,
    required this.id,
  });
}

List<UserLocation> nearbyUsers = [];
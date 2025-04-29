import 'dart:math';
import 'package:flutter/material.dart';

class LocationUtils {
  static Offset? calculatePosition(
      double centerLatitude,
      double centerLongitude,
      double targetLatitude,
      double targetLongitude) {
    // Radius of the circle
    final double radius = 100;

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = centerLatitude * (pi / 180);
    double lon1Rad = centerLongitude * (pi / 180);
    double lat2Rad = targetLatitude * (pi / 180);
    double lon2Rad = targetLongitude * (pi / 180);

    // Calculate the differences in latitude and longitude
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;

    // Haversine formula to calculate the distance between the two points
    double a = pow(sin(deltaLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(deltaLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = 6371 * c; // Earth's radius in kilometers

    // If the distance is greater than the radius return null
    if (distance > (radius / 1000)){
      return null;
    }

    // Calculate the angle (bearing) from center to target
    double y = sin(deltaLon) * cos(lat2Rad);
    double x = cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(deltaLon);
    double theta = atan2(y, x);

    // Calculate the position in polar coordinates
    double xPos = radius * cos(theta);
    double yPos = radius * sin(theta);

    // Return the position as an Offset
    return Offset(xPos, yPos);
  }
}
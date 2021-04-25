import 'dart:math';

import 'package:latlong/latlong.dart';

class LocationHelper {
  static double bearingBetweenLocations(
      double lats1, double lons1, double lats2, double lons2) {
    print("Location" +
        lats1.toString() +
        lons1.toString() +
        lats2.toString() +
        lons2.toString());

    double PI = 3.14159;
    double lat1 = lats1 * PI / 180;
    double long1 = lons1 * PI / 180;
    double lat2 = lats2 * PI / 180;
    double long2 = lons2 * PI / 180;
    double dLon = (long2 - long1);
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double brng = radianToDeg(atan2(y, x));

    brng = (brng + 360) % 360;

    return brng;
  }
}

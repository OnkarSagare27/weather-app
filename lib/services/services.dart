import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/models/conts.dart';
import 'package:weather/models/location_model.dart';
import 'package:weather/models/weather_model.dart';

// Fetch current location

Future<LocationModel> getCurrentLocation() async {
  String city;
  String state;
  String country;
  try {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
    ].request();
    statuses.forEach(
      (permission, status) {
        if (status == PermissionStatus.denied) {
          openAppSettings();
        } else if (status == PermissionStatus.granted) {}
      },
    );
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      city = placemark.locality != null ? placemark.locality! : '';
      state = placemark.administrativeArea != null
          ? placemark.administrativeArea!
          : '';
      country = placemark.country != null ? placemark.country! : '';

      return LocationModel(
        name: city,
        state: state,
        country: country,
        lat: position.latitude,
        lon: position.longitude,
      );
    }
    throw Exception('Location not found.');
  } catch (e) {
    throw Exception('Location not found.');
  }
}

Future<WeatherModel> getWeather(double lat, double lon) async {
  final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=en&appid=${Strings.apiKey}');
  print(uri);
  final res = await http.get(uri);
  if (res.statusCode == 200) {
    dynamic data = jsonDecode(const Utf8Decoder().convert(res.bodyBytes));

    return WeatherModel.fromJson(data);
  } else {
    throw Exception('Weather data not found. Status code: ${res.statusCode}');
  }
}

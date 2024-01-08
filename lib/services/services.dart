import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/models/const.dart';
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
      desiredAccuracy: LocationAccuracy.low,
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
    throw Exception(e);
  }
}

Future<WeatherModel> getWeather(double lat, double lon) async {
  final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=en&appid=${Strings.apiKey}');

  final res = await http.get(uri);
  if (res.statusCode == 200) {
    dynamic data = jsonDecode(const Utf8Decoder().convert(res.bodyBytes));

    return WeatherModel.fromJson(data);
  } else {
    throw Exception('Weather data not found. Status code: ${res.statusCode}');
  }
}

// City search

Future<List<LocationModel>> fetchCities(String input) async {
  final uri = Uri.parse(
      'http://api.openweathermap.org/geo/1.0/direct?q=$input&limit=5&appid=${Strings.apiKey}');

  final res = await http.get(uri);
  if (res.statusCode == 200) {
    List<dynamic> data = jsonDecode(const Utf8Decoder().convert(res.bodyBytes));
    List<LocationModel> modelsList = data
        .map(
          (city) => LocationModel(
            name: city['name'],
            state: city['state'],
            country: city['country'],
            lat: city['lat'],
            lon: city['lon'],
          ),
        )
        .toList();

    return modelsList;
  } else {
    return [];
  }
}

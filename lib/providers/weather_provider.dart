import 'package:flutter/material.dart';
import 'package:weather/models/location_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/services.dart';

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;

  LocationModel? _currentLocationModel;
  LocationModel? get currentLocationModel => _currentLocationModel;

  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;

  Future<void> getCurrentLocationWeather() async {
    LocationModel currentLocationModelTmp = await getCurrentLocation();
    WeatherModel weather = await getWeather(
        currentLocationModelTmp.lat, currentLocationModelTmp.lon);
    _currentLocationModel = currentLocationModelTmp;
    _weatherModel = weather;
    notifyListeners();
  }

  LocationModel? selectedLocation;
}

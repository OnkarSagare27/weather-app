import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/location_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/services.dart';

// Provider

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;

  LocationModel? _currentLocationModel;
  LocationModel? get currentLocationModel => _currentLocationModel;

  WeatherModel? _currentLocationWeatherModel;
  WeatherModel? get currentLocationWeatherModel => _currentLocationWeatherModel;

  List<LocationModel>? _suggestedCities;
  List<LocationModel>? get suggestedCities => _suggestedCities;

  LocationModel? _selectedLocationModel;
  LocationModel? get selectedLocationModel => _selectedLocationModel;

  set selectedLocationModel(LocationModel? value) {
    _selectedLocationModel = value;
    notifyListeners();
  }

  WeatherModel? _selectedLocationWeatherModel;
  WeatherModel? get selectedLocationWeatherModel =>
      _selectedLocationWeatherModel;

  set selectedLocationWeatherModel(WeatherModel? value) {
    _selectedLocationWeatherModel = value;
    notifyListeners();
  }

  List<dynamic>? _bookmarkedLocations;
  List<dynamic>? get bookmarkedLocations => _bookmarkedLocations;

  bool _isBookmarkLoading = false;
  bool get isBookmarkLoading => _isBookmarkLoading;

  // Fetch current location weather

  Future<void> getCurrentLocationWeather() async {
    LocationModel currentLocationModelTmp = await getCurrentLocation();
    WeatherModel weather = await getWeather(
        currentLocationModelTmp.lat, currentLocationModelTmp.lon);
    _currentLocationModel = currentLocationModelTmp;
    _currentLocationWeatherModel = weather;
    notifyListeners();
  }

  // Get searched location weather

  Future<void> getSelectedLocationWeather() async {
    WeatherModel weather = await getWeather(
        selectedLocationModel!.lat, selectedLocationModel!.lon);
    _selectedLocationWeatherModel = weather;
    notifyListeners();
  }

  // Update suggestions for searched city name

  Future<void> fetchCitieseFunc(String input) async {
    _suggestedCities = await fetchCities(input);
    notifyListeners();
  }

  void loadBookmarks() async {
    SharedPreferences preffs = await SharedPreferences.getInstance();

    dynamic data = preffs.getString('bookmarks') ?? '[]';

    List<dynamic> bookmarks = jsonDecode(data);

    _bookmarkedLocations = bookmarks;

    notifyListeners();
  }

  void addToBookmarks(Map<String, dynamic> map) async {
    _isBookmarkLoading = true;
    notifyListeners();
    SharedPreferences preffs = await SharedPreferences.getInstance();
    dynamic data = preffs.getString('bookmarks') ?? '[]';

    List<dynamic> bookmarks = jsonDecode(data);
    bookmarks.add(map);
    preffs.setString('bookmarks', jsonEncode(bookmarks));
    _bookmarkedLocations = bookmarks;
    _isBookmarkLoading = false;

    notifyListeners();
  }

  void removeFromBookmarks(Map<String, dynamic> map) async {
    _isBookmarkLoading = true;
    notifyListeners();
    SharedPreferences preffs = await SharedPreferences.getInstance();
    dynamic data = preffs.getString("bookmarks") ?? '[]';

    List<dynamic> bookmarks = jsonDecode(data);
    bookmarks.removeWhere((item) =>
        item["name"] == map["name"] &&
        item["state"] == map["state"] &&
        item["country"] == map["country"]);

    preffs.setString('bookmarks', jsonEncode(bookmarks));
    _bookmarkedLocations = bookmarks;
    _isBookmarkLoading = false;

    notifyListeners();
  }
}

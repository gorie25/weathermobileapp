import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/weather_repo.dart';

class WeatherProvider extends ChangeNotifier {
  late Weather weather;
  String location = '';


  updateLocation(String currentLocation) {
    location = currentLocation;
     print(location);
    notifyListeners();
  }
  Future<Weather> getWeather() async {
  Weather response = await WeatherRepository().fetchWeather(location);  

    weather=response;
    notifyListeners();
    return weather;
}
}
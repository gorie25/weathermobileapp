// weather_repo.dart
import 'dart:convert';

import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
class WeatherRepository {
  Future<Weather> fetchWeather(String location) async {
    // Fetch weather data from an API or database
    // For example, let's assume we get a JSON response and parse it into a list of Weather objects
final response = await http.get(
  Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=af0181935ff9499faf771236240811&days=7&q=$location')
);    

if (response.statusCode == 200) {
  Map<String, dynamic> data = json.decode(response.body);
  // Lấy thông tin thời tiết từ JSON và chuyển đổi nó
  return Weather.fromJson(data); // Giả sử `Weather.fromJson` có thể xử lý cấu trúc JSON của API này
} else {
  throw Exception('Failed to load weather data');
}

  }
}
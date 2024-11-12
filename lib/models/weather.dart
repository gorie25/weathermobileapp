import 'dart:convert';


//Weather sẽ gồm 3 class con là Location, Current , DailyForecast 
class Weather {
  final Location location;
  final CurrentWeather currentWeather;
  final List<ForecastDay> forecastDay;

  Weather({
    required this.location,
    required this.currentWeather,
    required this.forecastDay,
  });

  // Tạo một factory constructor để chuyển đổi JSON thành đối tượng Weather
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      currentWeather: CurrentWeather.fromJson(json['current']),
     forecastDay : (json['forecast']['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      localtime: json['localtime'],
    );
  }
}

class CurrentWeather {
  final String condition;
  final int temperature;
  final int windSpeed;
  final int humidity;
  final int cloud;

  CurrentWeather({
    required this.condition,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      condition: json['condition']['text'],
      temperature: json['temp_c'].toInt(),
      windSpeed: json['wind_kph'].toInt(),
      humidity: json['humidity'].toInt(),
      cloud: json['cloud'].toInt(),
    );
  }
}

class ForecastDay {
  final String date;
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final double maxWindSpeed;
  final int avgHumidity;
  final int chanceOfRain;
  final String condition;
  final String weatherIcon;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.maxWindSpeed,
    required this.avgHumidity,
    required this.chanceOfRain,
    required this.condition,
    required this.weatherIcon,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      maxtempC: json['day']['maxtemp_c'],
      mintempC: json['day']['mintemp_c'],
      avgtempC: json['day']['avgtemp_c'],
      maxWindSpeed: json['day']['maxwind_kph'],
      avgHumidity: json['day']['avghumidity'],
      chanceOfRain: json['day']['daily_chance_of_rain'],
      condition: json['day']['condition']['text'],
      weatherIcon: json['day']['condition']['icon'],
      hour: (json['hour'] as List).map((item) => Hour.fromJson(item)).toList(),
    );
  }
}
class Hour {
  final String time;
  final double tempC;
  final String condition;

  Hour({
    required this.time,
    required this.tempC,
    required this.condition,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'],
      tempC: json['temp_c'],
      condition: json['condition']['text'],
    );
  }
}
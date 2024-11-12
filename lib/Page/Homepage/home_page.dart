import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Page/EmailPage/email.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/Utils/constants.dart';
import 'package:weather_app/Page/Detailpage/detail_page.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();
  City? selectedCity = City.citiesList[0];

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return EmailDialog(
                    forecastData: [
                      {
                        'date': '2023-10-01',
                        'condition': 'Sunny',
                        'mintempC': 20,
                        'maxtempC': 30,
                        'weatherIcon': 'sunny',
                        'chanceOfRain': 10
                      },
                      {
                        'date': '2023-10-02',
                        'condition': 'Cloudy',
                        'mintempC': 18,
                        'maxtempC': 28,
                        'weatherIcon': 'cloudy',
                        'chanceOfRain': 20
                      },
                      // Add more forecast data here
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: context.watch<WeatherProvider>().getWeather(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('No Data');
            }
            if (!snapshot.hasData) {
              // Kiểm tra nếu không có dữ liệu
              return Center(child: Text('No Weather Data Available'));
            }

            Weather data = snapshot.data as Weather; // Lấy phần tử đầu tiên
            return SingleChildScrollView(
              // Add SingleChildScrollView to prevent overflow
              child: Container(
                width: size.width,
                padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
                color: _constants.primaryColor.withOpacity(.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Weather info container
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        gradient: _constants.linearGradientBlue,
                        boxShadow: [
                          BoxShadow(
                            color: _constants.primaryColor.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/menu.png",
                                width: 40,
                                height: 40,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    child: DropdownButton<City>(
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.blueAccent),
                                      value: selectedCity,
                                      hint: Text(
                                        "Select a City",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onChanged: (City? newValue) {
                                        setState(() {
                                          selectedCity = newValue;
                                          context
                                              .read<WeatherProvider>()
                                              .updateLocation(
                                                  selectedCity!.city);
                                          context
                                              .read<WeatherProvider>()
                                              .getWeather();
                                        });
                                        // Gọi hàm lấy dữ liệu thời tiết từ WeatherProvider

                                        // print(data.currentWeather.temperature);
                                      },
                                      underline:
                                          SizedBox(), // Loại bỏ gạch chân
                                      dropdownColor: Colors.white,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16),
                                      items: City.citiesList.map((City city) {
                                        return DropdownMenuItem<City>(
                                          value: city,
                                          child: Text(city.city),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/profile.png",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                          // print(data.currentWeather.condition),

                          SizedBox(
                            height: 160,
                            child: Image.asset("assets/" +
                                data.currentWeather.condition
                                    .toLowerCase()
                                    .replaceAll(' ', '') +
                                ".png"),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  data.currentWeather.temperature.toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                              ),
                              Text(
                                'o',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = _constants.shader,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            data.currentWeather.condition,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            DateFormat("MMMMEEEEd").format(
                                DateTime.parse(data.forecastDay[0].date)),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Divider(
                              color: Colors.white70,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherItem(
                                  value: data.currentWeather.windSpeed.toInt(),
                                  unit: 'km/h',
                                  imageUrl: 'assets/windspeed.png',
                                ),
                                WeatherItem(
                                  value: data.currentWeather.humidity.toInt(),
                                  unit: '%',
                                  imageUrl: 'assets/humidity.png',
                                ),
                                WeatherItem(
                                  value: data.currentWeather.cloud.toInt(),
                                  unit: '%',
                                  imageUrl: 'assets/cloud.png',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Forecast section with horizontal scrolling
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Today',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailPage(
                                              dailyForecastWeather:
                                                  data.forecastDay,
                                            ))),
                                child: Text(
                                  'Forecasts',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: _constants.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 110,
                            child: ListView.builder(
                              itemCount: data.forecastDay[0].hour.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    // handle tap
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/" +
                                              data.forecastDay[0].hour[index]
                                                  .condition
                                                  .replaceAll(' ', '')
                                                  .toLowerCase() +
                                              ".png",
                                          width: 40,
                                          height: 40,
                                        ),
                                        Text(
                                          data.forecastDay[0].hour[index].time
                                              .substring(11, 16),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          data.forecastDay[0].hour[index].tempC
                                                  .toString() +
                                              '°',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
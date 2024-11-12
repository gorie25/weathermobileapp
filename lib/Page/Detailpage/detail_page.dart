import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/Utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/Page/Detailpage/widget_day.dart';

class DetailPage extends StatefulWidget {
  List<ForecastDay> dailyForecastWeather;

  DetailPage({Key? key, required this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<ForecastDay> weatherData = widget.dailyForecastWeather;


return Scaffold(
  backgroundColor: _constants.primaryColor,
  appBar: AppBar(
    title: const Text('Forecasts'),
    centerTitle: true,
    backgroundColor: _constants.primaryColor,
    elevation: 0.0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
            onPressed: () {
              print("Settings Tapped!");
            },
            icon: const Icon(Icons.settings)),
      )
    ],
  ),
  body: Stack(
    alignment: Alignment.center,
    clipBehavior: Clip.none,
    children: [
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          height: size.height * .75,
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -50,
                right: 20,
                left: 20,
                child: Container(
                  height: 300,
                  width: size.width * .7,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.center,
                        colors: [
                          Color(0xffa9c1f5),
                          Color(0xff6696f5),
                        ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.1),
                        offset: const Offset(0, 25),
                        blurRadius: 3,
                        spreadRadius: -10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        child: Image.asset  ("assets/" +
                                              weatherData[0].condition
                                                  .replaceAll(' ', '')
                                                  .toLowerCase() +
                                              ".png",),
                        width: 150,
                      ),
                      Positioned(
                          top: 150,
                          left: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                          weatherData[0].condition.toString(),
                           
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          )),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Container(
                          width: size.width * .8,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WeatherItem(
                                  value: weatherData[0].avgHumidity ,  
                                  unit: "km/h",
                                  imageUrl: "assets/windspeed.png",
                                ),
                              ),
                              Expanded(
                                child: WeatherItem(
                                  value: weatherData[0].avgHumidity,  
                                  unit: "%",
                                  imageUrl: "assets/humidity.png",
                                ),
                              ),
                              Expanded(
                                child: WeatherItem(
                                  value: weatherData[0].chanceOfRain,
                                  unit: "%",
                                  imageUrl: "assets/lightrain.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             weatherData[0].maxtempC.toString(),
      

                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = _constants.shader,
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
                      ),
                          
                    ],
                  ),
                ),
              ),

                Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: size.height * .4,
                      child: WidgetDay(
                        forecastData: weatherData,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
      
    ],

  ),
);
  }
}
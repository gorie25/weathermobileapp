import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Utils/constants.dart';
import 'package:weather_app/models/weather.dart';

class WidgetDay extends StatelessWidget {
  final List<ForecastDay> forecastData;

  const WidgetDay({Key? key, required this.forecastData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants _constants = Constants();
    return Positioned(
      top: 320,
      left: 0,
      child: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width * .9,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: forecastData.length-1,
          itemBuilder: (context, index) {
            final weatherData = forecastData[index+1];
            return Card(
              elevation: 3.0,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(

                                 DateFormat("MMMMEEEEd").format(
                                  DateTime.parse(weatherData.date.toString())),
                          style: const TextStyle(
                            color: Color(0xff6696f5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  weatherData.mintempC.toString(),
                                  style: TextStyle(
                                    color: _constants.greyColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                      color: _constants.greyColor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      fontFeatures: const [
                                        FontFeature.enable('sups'),
                                      ]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  weatherData.maxtempC.toString(),
                                  style: TextStyle(
                                    color: _constants.blackColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                      color: _constants.blackColor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      fontFeatures: const [
                                        FontFeature.enable('sups'),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                            "assets/" +
                                              weatherData.condition
                                                  .replaceAll(' ', '')
                                                  .toLowerCase() +
                                              ".png",
                              width: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              weatherData.condition,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weatherData.chanceOfRain.toString() + "%",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              'assets/lightrain.png',
                              width: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
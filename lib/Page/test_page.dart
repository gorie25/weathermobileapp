import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/models/weather.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  City? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: context.read<WeatherProvider>().getWeather(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('No Data');
            }

            Weather data = snapshot.data as Weather; // Lấy phần tử đầu tiên
            print(data.currentWeather.temperature);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent, width: 1),
                  ),
                  child: DropdownButton<City>(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                    value: selectedCity,
                    hint: Text(
                      "Select a City",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onChanged: (City? newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                    underline: SizedBox(), // Loại bỏ gạch chân
                    dropdownColor: Colors.white,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    items: City.citiesList.map((City city) {
                      return DropdownMenuItem<City>(
                        value: city,
                        child: Text(city.city),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  data.currentWeather.temperature.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Page/EmailPage/email.dart';
import 'package:weather_app/Page/Homepage/home_page.dart';
import 'package:weather_app/Page/Loginpage/signin.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String currentLocation = 'London';
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherProvider>(create: (context) {
          final provider = WeatherProvider();
          provider.updateLocation(currentLocation);
          
          return provider;
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SignInPage(), // Show EmailScreen on app start
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
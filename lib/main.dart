import 'package:flutter/material.dart';
import 'package:weathermap/screens/location_screen.dart';
import 'package:weathermap/screens/weather_forecast_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LocationScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/weather_page.dart'; // IMPORTANT: Adjust path if WeatherPage is in a different directory

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather App',
      theme: ThemeData(
        // You can customize your app's theme here
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        useMaterial3: true,
      ),
      // The WeatherPage is the first screen of the app
      home: const WeatherPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class CurrentTempDisplay extends StatelessWidget {
  final Weather weather;

  const CurrentTempDisplay({
    super.key,
    required this.weather,
  });

  // Logic for determining the correct image path
  String _getWeatherImagePath(String? mainCondition) {
    if (mainCondition == null) return "assets/images/sun.png";

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/images/clouds.png';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/images/heavy-rain.png';
      case 'thunderstorm':
        return 'assets/images/storm.png';
      case 'clear':
        return 'assets/images/sun.png';
      default:
        return 'assets/images/sun.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.height * 0.20,
          child: Image.asset(
            _getWeatherImagePath(weather.weatherMain), // Call the local method
            fit: BoxFit.contain,
          ),
        ),
        Text(
          "${weather.temperature?.celsius?.toStringAsFixed(0) ?? 'N/A'}° C",
          style: GoogleFonts.aboreto(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
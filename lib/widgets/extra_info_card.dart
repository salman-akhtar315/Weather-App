import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class ExtraInfoCard extends StatelessWidget {
  final Weather weather;

  const ExtraInfoCard({super.key, required this.weather});

  Widget _infoRow(String label1, String value1, String label2, String value2) {
    TextStyle style = GoogleFonts.akshar(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "$label1: $value1",
          style: style,
        ),
        Text(
          "$label2: $value2",
          style: style,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _infoRow(
              "Max",
              "${weather.tempMax!.celsius!.toStringAsFixed(0)}° C",
              "Min",
              "${weather.tempMin!.celsius!.toStringAsFixed(0)}° C"
          ),
          _infoRow(
              "Wind",
              "${weather.windSpeed!.toStringAsFixed(1)} m/s",
              "Humidity",
              "${weather.humidity!.toStringAsFixed(0)}%"
          ),
        ],
      ),
    );
  }
}
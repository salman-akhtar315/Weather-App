import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/current_temp_display.dart';
import 'package:weather_app/widgets/extra_info_card.dart';

// OpenWeatherMap API Key
// const String OPENWEATHER_API_KEY = "c8559f0278fc4f5fba4830795d3c044e";

const String OPENWEATHER_API_KEY = "f8d3eb34ec08857843b465901cc2c18c";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  String _cityName = "Sahiwal"; // Default city
  final TextEditingController _cityController = TextEditingController();

  Future<void> _fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a city name.")),
        );
      }
      return;
    }
    try {
      Weather w = await _wf.currentWeatherByCityName(cityName);
      setState(() {
        _weather = w;
        _cityName = cityName;
      });
      _cityController.clear();
    } catch (e) {
      print("Error fetching weather: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error fetching weather. Check city name/API.")),
        );
      }
      setState(() {
        _weather = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchWeather(_cityName);
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  // --- Build Methods ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 30),
          _titleSection(),
          _searchBar(),
          Expanded(
            child: _weather == null
                ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                : _weatherDetails(),
          ),
        ],
      ),
    );
  }

  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check Weather Condition',
            style: GoogleFonts.akshar(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextField(
          controller: _cityController,
          decoration: InputDecoration(
            hintText: 'Search a City',
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.blue),
              onPressed: () {
                if (_cityController.text.isNotEmpty) {
                  _fetchWeather(_cityController.text);
                }
              },
            ),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _fetchWeather(value);
            }
          },
        ),
      ),
    );
  }

  Widget _weatherDetails() {
    if (_weather == null) {
      return const Center(child: Text("Failed to load weather data.", style: TextStyle(color: Colors.white, fontSize: 18)));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          // Using the specialized widget for icon and temperature
          CurrentTempDisplay(
            weather: _weather!,
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          _currentTempDescription(), // Renamed for clarity
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          // Using the specialized widget for extra information
          ExtraInfoCard(weather: _weather!),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "Unknown Location",
      style: GoogleFonts.akshar(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _currentTempDescription() {
    return Text(
      _weather?.weatherDescription ?? "Loading weather...",
      style: GoogleFonts.akshar(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meteo/models/weather_model.dart';
import 'package:meteo/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('d60b1e7d89ee3fbcea489b061c239811');
  Weather? _weather;

  //fetch weather 
  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather condition
  String getWeatherAnimation(String? mainCondition){

    if(mainCondition == null) return 'assets/json/sunny.json';

    switch (mainCondition) {
      case 'Clouds':
          return 'assets/json/cloud.json';
      case 'Mist':
          return 'assets/json/sunny.json';
      case 'Smoke':
          return 'assets/json/sunny.json';
      case 'Fog':
          return 'assets/json/cloud.json';
      case 'Dust':
          return 'assets/json/sunny.json';
      case 'Drizzle':
          return 'assets/json/sunny.json';
      case 'Shwo rain':
          return 'assets/json/rain.json';
      case 'Rain':
          return 'assets/json/rain.json';
      case 'Thunderstorm':
          return 'assets/json/thunder.json';
      case 'Thunder':
          return 'assets/json/thunder.json';
      case 'Clear':
          return 'assets/json/sunny.json';
      default:
        return 'assets/json/sunny.json';
    }
  }
  //init
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //nom de la ville
            Text(_weather?.cityName??"Rechargement de la ville..."),

            //Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature.round()}°C'),

            //weather condition
            Text(_weather?.mainCondition ??""),
          ],
          ),
      ),
    );
  }
}
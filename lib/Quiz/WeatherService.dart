import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_stateful/Quiz/model/weatherModel.dart';
import 'package:flutter/material.dart';

class WeatherService {
  static const _apiKey = "802ad5b23c768c69c63ddf9ff216088c";
  static const _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Weather _parseWeather(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Weather.fromJson(json);
  }

  Future<List<Weather>> fetchMultipleCitiesWeather(List<String> cities) async {
    List<Weather> weatherList = [];

    for (String city in cities) {
      try {
        final response = await http.get(
          Uri.parse("$_baseUrl?q=$city&appid=$_apiKey&units=metric"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );

        if (response.statusCode == 200) {
          Weather weather = _parseWeather(response.body);
          weatherList.add(weather);
        } else {
          debugPrint(
            "Failed to load weather for $city: ${response.statusCode}",
          );
        }
      } catch (e) {
        debugPrint("Error fetching weather for $city: $e");
      }
    }

    return weatherList;
  }

  Future<Weather> searchWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      throw Exception("Please enter a city name");
    }

    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?q=${cityName.trim()}&appid=$_apiKey&units=metric"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return _parseWeather(response.body);
      } else if (response.statusCode == 404) {
        throw Exception("City not found. Please check the spelling.");
      } else {
        throw Exception("Failed to load weather data. Please try again.");
      }
    } catch (e) {
      throw Exception("Network error. Please check your connection.");
    }
  }
}

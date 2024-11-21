import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_application/src/Model/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? weatherData;

  Future<WeatherModel?> fetchWeather(String apiUrl) async {
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        weatherData = WeatherModel.fromJson(jsonData);

        notifyListeners();
        return weatherData;
      } else {
        debugPrint(
            "Failed to fetch weather data. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching weather data: $e");
      return null;
    }
  }
}

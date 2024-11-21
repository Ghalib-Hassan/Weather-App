import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/src/Provider/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String getSkyImage(int temperature, String condition) {
    if (temperature >= 30 && condition.contains('clear')) {
      return 'Images/Sun.png'; // Replace with your sunny image asset path
    } else if (temperature <= 0 && condition.contains('cloud')) {
      return 'Images/Cloud.png'; // Replace with your cloudy image asset path
    } else if (condition.contains('rain')) {
      return 'Images/RainCloud.png'; // Replace with your rainy image asset path
    } else {
      return 'Images/Sun.png'; // Default image
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Weather Info",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: weatherProvider.weatherData == null
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  weatherProvider.fetchWeather(
                      'http://api.weatherstack.com/current?access_key=121a56f297b261ade4905fbd2d2cc9f9&query=Peshawar'); // Replace with your API URL
                },
                child: const Text("Fetch Weather"),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      getSkyImage(
                        weatherProvider.weatherData?.current?.temperature ?? 0,
                        weatherProvider.weatherData?.current
                                ?.weatherDescriptions?.first
                                .toLowerCase() ??
                            '',
                      ),
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      weatherProvider.weatherData?.location?.name ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Temperature: ${weatherProvider.weatherData?.current?.temperature ?? 'N/A'}°C",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Humidity: ${weatherProvider.weatherData?.current?.humidity ?? 'N/A'}%",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Time: ${weatherProvider.weatherData?.location?.localtime ?? 'N/A'}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

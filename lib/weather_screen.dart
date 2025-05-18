import "dart:ui";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:weather_app/additional_info_card.dart";
import "package:weather_app/api_key.dart";
import "package:weather_app/hourly_weather_card.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }
  Future getCurrentWeather() async {
    String city = "London";
    final result = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apikey'),);
    debugPrint(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //placeholder for main card of the app
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "100°F",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Icon(Icons.cloud, size: 100),
                          const SizedBox(height: 10),
                          Text(
                            "Cloudy",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //for gap
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Weather Forecast",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            //placeholder for weatherforecast cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                  HourlyWeatherCard(timeofday:"12:00 PM",icon:Icons.cloud, temperature: 100),
                  HourlyWeatherCard(timeofday:"1:00 PM", icon:Icons.sunny,temperature: 125),
                  HourlyWeatherCard(timeofday:"2:00 PM", icon:Icons.storm,temperature: 110),
                  HourlyWeatherCard(timeofday:"3:00 PM", icon:Icons.wind_power_outlined,temperature: 90),
                  HourlyWeatherCard(timeofday:"4:00 PM", icon:Icons.cloud,temperature: 111),
                ],
              ),
            ),
            // const Placeholder(fallbackHeight: 150),
            const SizedBox(height: 10),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Additional Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AddtionalInfoCard(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: "50%",
                ),
                AddtionalInfoCard(
                  icon: Icons.air,
                  label: "Wind Speed",
                  value: "10 km/h",
                ),
                AddtionalInfoCard(
                  icon: Icons.visibility,
                  label: "Visibility",
                  value: "10 km",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



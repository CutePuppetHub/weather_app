import "dart:convert";
import "dart:ui";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";
import "package:weather_app/additional_info_card.dart";
import "package:weather_app/api_key.dart";
import "package:weather_app/hourly_weather_card.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temperature = 0;
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String city = "London";
      final result = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$apikey',
        ),
      );
      // debugPrint(result.body);
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw Exception('Failed to load weather data');
      }
      // setState(() {
      //   // temperature = double.parse(response['list'][0]['main']['temp'].toString());
      // });
      return data;
    } catch (e) {
      throw e.toString();
    }
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
              setState(() {
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemperature = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['description'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          return Padding(
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
                                "$currentTemperature K",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Icon(
                                data['list'][0]['weather'][0]['main'] ==
                                            "clouds" ||
                                        data['list'][0]['weather'][0]['main'] ==
                                            "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 100,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "$currentSky",
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
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                //placeholder for weatherforecast cards
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 1; i < 6; i++)
                //         HourlyWeatherCard(
                //           timeofday: data['list'][i]['dt_txt'].toString().split(" ")[1].substring(0, 5),
                //           icon: data['list'][i]['weather'][0]['main'] == "clouds" || data['list'][i]['weather'][0]['main'] == "Rain" ? Icons.cloud : Icons.sunny,
                //           temperature: data['list'][i]['main']['temp'].round(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 125,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(
                        data['list'][index + 1]['dt_txt'],
                      );
                      return HourlyWeatherCard(
                        timeofday: DateFormat.j().format(time),
                        icon:
                            data['list'][index + 1]['weather'][0]['main'] ==
                                        "clouds" ||
                                    data['list'][index +
                                            1]['weather'][0]['main'] ==
                                        "Rain"
                                ? Icons.cloud
                                : Icons.sunny,
                        temperature:
                            data['list'][index + 1]['main']['temp'].round(),
                      );
                    },
                  ),
                ),

                // // const Placeholder(fallbackHeight: 150),
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
                      value: "$currentHumidity %",
                    ),
                    AddtionalInfoCard(
                      icon: Icons.air,
                      label: "Wind Speed",
                      value: "$currentWindSpeed m/s",
                    ),
                    AddtionalInfoCard(
                      icon: Icons.umbrella_outlined,
                      label: "Pressure",
                      value: "$currentPressure hPa",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

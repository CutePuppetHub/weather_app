import "dart:ui";

import "package:flutter/material.dart";

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Icon(
                            Icons.cloud,
                            size: 100,
                           
                          ),
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
            const Text(
              "Weather Forecast",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
            ),
            //placeholder for weatherforecast cards
            const Placeholder(fallbackHeight: 150),
            const SizedBox(height: 20),
            //placeholder for weather additionalinformation
            const Placeholder(fallbackHeight: 150),
          ],
        ),
      ),
    );
  }
}

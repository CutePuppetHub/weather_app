import 'package:flutter/material.dart';

//class for the weatherforecast hourly cards
class HourlyWeatherCard extends StatelessWidget {
  final String timeofday;
  final int temperature;
  final IconData icon;
  const HourlyWeatherCard({
    super.key,
    required this.timeofday,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(
              timeofday,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Icon(icon, size: 32),
            SizedBox(height: 10),
            Text("$temperature K", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';
import 'package:flutter/rendering.dart';


void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,



      home: const WeatherScreen(),
      //how to make the background color change to someotheer
      theme: ThemeData.dark(useMaterial3: true )
    );
  }
}

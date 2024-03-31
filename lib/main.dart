import 'package:flutter/material.dart';
import 'package:university_app_latest/login.dart';

void main() {
  runApp(MaterialApp(
      title: 'University Tracer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Colors.white, //elements inside containers
          secondary: Color.fromARGB(255, 105, 85, 177), // text color.
          surface: Color.fromARGB(255, 130, 113,
              184), // appbar background color, text color  applied to text on surfaces like cards or panels.
          background: Color.fromARGB(
              255, 255, 255, 255), //color represents the overall background
          error: Colors.grey, //errors or warnings
          onPrimary: Color.fromARGB(255, 105, 85,
              177), //text that appears on top of primary-colored backgrounds
          onSecondary: Colors
              .white, //text that appears on top of secondary-colored backgrounds.
          onSurface: Colors
              .white, // text that appears on top of surfaces like cards or panels.
          onBackground:
              Colors.white, // text that appears on top of the background.
          onError: Colors.grey, //text that indicates errors or warnings.
          brightness: Brightness
              .light, //Specifies whether the color scheme is for a light or dark theme
        ),
      ),
      home: loginpage()));
}

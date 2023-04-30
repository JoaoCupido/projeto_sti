import 'package:flutter/material.dart';
import 'package:projeto_sti/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetSupply',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFFF28A0C),
          secondary: Color(0xFFF2E0CB),
          surface: Colors.white,
          background: Color(0xFFEDFFFC),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light, // Set the theme brightness to light
        ),
      ),
      home: OnboardingScreen(), // Set OnboardingScreen as the home screen
    );
  }
}

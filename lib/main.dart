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
      title: 'My App',
      home: OnboardingScreen(), // Set OnboardingScreen as the home screen
    );
  }
}

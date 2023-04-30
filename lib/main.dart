import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_sti/onboarding_screen.dart';
import 'package:projeto_sti/account_session.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return MaterialApp(
          title: 'PetSupply',
          routes: {
            '/login': (context) => const LoginPage(),
          },
          theme: ThemeData(
            colorScheme: const ColorScheme(
              primary: Color(0xFFF28A0C),
              secondary: Color(0xFFF2E0CB),
              surface: Colors.white,
              background: Color(0xFFEDFFFC),
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Color(0xFF111111),
              onBackground: Color(0xFF111111),
              onError: Colors.white,
              brightness: Brightness.light, // Set the theme brightness to light
            ),
            textTheme: const TextTheme(
              displaySmall: TextStyle(
                color: Color(0xFF111111),
                fontWeight: FontWeight.w500,
              ),
              bodyLarge: TextStyle(
                color: Color(0xFF767676),
              ),
              labelLarge: TextStyle(
                color: Color(0xFF767676),
              ),
            ),
            tabBarTheme: const TabBarTheme(
              labelColor: Color(0xFFF28A0C),
              unselectedLabelColor: Color(0xFF111111),
              //indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          home: OnboardingScreen(), // Set OnboardingScreen as the home screen
        );
      },
    );
  }
}

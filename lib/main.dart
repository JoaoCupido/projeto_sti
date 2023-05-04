import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_sti/onboarding_screen.dart';
import 'package:projeto_sti/account_session.dart';
import 'package:projeto_sti/recover_account_1.dart';
import 'package:projeto_sti/recover_account_2.dart';
import 'package:projeto_sti/recover_account_3.dart';
import 'package:projeto_sti/home_screen.dart';

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
            '/tutorial': (context) => const OnboardingScreen(),
            '/login': (context) => const AccountSessionScreen(),
            '/recover-account': (context) => const RecoverAccount1(),
            '/recover-account-2': (context) => const RecoverAccount2(),
            '/recover-account-3': (context) => const RecoverAccount3(),
            '/home': (context) => const MainMenuScreen(),
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
              outline: Color(0xFF111111),
              outlineVariant: Color(0xFFAAAAAA),

              surfaceVariant: Colors.amberAccent,

              brightness: Brightness.light, // Set the theme brightness to light
            ),
            textTheme: const TextTheme(
              displaySmall: TextStyle(
                color: Color(0xFF111111),
                fontWeight: FontWeight.w500,
              ),
              displayMedium: TextStyle(
                color: Color(0xFF111111),
                fontWeight: FontWeight.w500,
                fontSize: 35,
              ),
              titleLarge: TextStyle(
                color: Color(0xFF111111),
              ),
              titleMedium: TextStyle(
                color: Color(0xFF111111),
              ),
              bodyLarge: TextStyle(
                color: Color(0xFF767676),
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF767676),
              ),
              labelLarge: TextStyle(
                color: Color(0xFF767676),
              ),
              labelMedium: TextStyle(
                color: Color(0xFF111111),
              ),
            ),
          ),
          home: OnboardingScreen(), // Set OnboardingScreen as the home screen
        );
      },
    );
  }
}

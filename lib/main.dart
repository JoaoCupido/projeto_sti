import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_sti/onboarding_screen.dart';
import 'package:projeto_sti/account_session_screen.dart';
import 'package:projeto_sti/recover_account_screen1.dart';
import 'package:projeto_sti/recover_account_screen2.dart';
import 'package:projeto_sti/recover_account_screen3.dart';
import 'package:projeto_sti/bottom_nav_bar_screen.dart';
import 'package:projeto_sti/search_results_screen.dart';
import 'package:projeto_sti/user_account_screen.dart';
import 'package:projeto_sti/user_profile_screen.dart';
import 'dados_faturação.dart';
import 'dados_faturação2.dart';
import 'item_screen.dart';
import 'metodos_pagamento.dart';
import 'metodos_pagamento2.dart';
import 'help_screen.dart';

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
            '/recover-account-2': (context) =>
                const RecoverAccount2(emailName: ''),
            '/recover-account-3': (context) => const RecoverAccount3(),
            '/home': (context) =>
                const BottomNavBarScreen(args: {'index': 0, 'emailName': ''}),
            '/user-account': (context) => const UserAccountScreen(),
            '/user-profile': (context) => const UserProfileScreen(),
            '/help': (context) => const HelpScreen(),
            '/search': (context) =>
                const SearchResultsScreen(args: {'emailName': '', 'query': ''}),
            '/dados_faturação': (context) => BillingDataPage(),
            '/dados_faturação2': (context) => BillingDataPage2(),
            '/metodos_pagamento': (context) => PaymentMethodsPage(),
            '/metodos_pagamento2': (context) => PaymentMethodsPage2(),
            '/item-screen': (context) =>
                const ItemScreen(args: {'emailName': '', 'query': '', 'itemTitle': 'Biscoito para cão Biscrok'}),
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

              //Para a estrela/review
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
          home:
              const OnboardingScreen(), // Set OnboardingScreen as the home screen
        );
      },
    );
  }
}

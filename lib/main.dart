// main.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleep_dev/screen/home_screen.dart';
import 'package:sleep_dev/screen/login_screen.dart';
import 'package:sleep_dev/screen/signup_screen.dart';
import 'package:sleep_dev/screen/sleep_detail_screen.dart';
import 'package:sleep_dev/screen/sleep_tips_screen.dart';
import 'package:sleep_dev/screen/splash_screen.dart';

void main() {
  runApp(const SleepApp());
}

class SleepApp extends StatelessWidget {
  const SleepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleep Dev',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/sleep-tips': (context) => const SleepTipsScreen(),
        '/sleep-detail': (context) => const SleepDetailScreen(),
      },
    );
  }
}

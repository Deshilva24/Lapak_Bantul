import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lapak Bantul',
      theme: ThemeData(
        // Menggunakan ColorScheme karena primarySwatch sudah mulai deprecated di Flutter baru
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A568C)),
        useMaterial3: true,
      ),
      // Memanggil class OnboardingScreen dari file splash_screen.dart kamu
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
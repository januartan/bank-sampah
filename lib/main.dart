// File: lib/main.dart
import 'package:flutter/material.dart';
import 'beranda_page.dart';

void main() {
  runApp(const BankSampahApp());
}

class BankSampahApp extends StatelessWidget {
  const BankSampahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Sampah',
      theme: ThemeData(
        primaryColor: Colors.green[700],
        scaffoldBackgroundColor: const Color(0xFFF1F8E9), // Background Hijau Muda
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const BerandaPage(), // Langsung masuk ke Beranda
    );
  }
}

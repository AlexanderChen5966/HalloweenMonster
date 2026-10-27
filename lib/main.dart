import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(const HalloweenApp());

class HalloweenApp extends StatelessWidget {
  const HalloweenApp({super.key});

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFFF7A18);
    return MaterialApp(
      title: '萬聖節妖怪圖鑑',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF14091F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: orange,
          brightness: Brightness.dark,
          surface: const Color(0xFF1E0F2E),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

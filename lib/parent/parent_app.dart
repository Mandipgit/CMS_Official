
import 'package:flutter/material.dart';
import 'package:official_cms/parent/Parent/lib/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class ParentApp extends StatefulWidget {
  const ParentApp({super.key});

  @override
  State<ParentApp> createState() => _ParentAppState();
}

class _ParentAppState extends State<ParentApp> {
  bool isDarkMode = false;

  void onToggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cms App',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onToggleDarkMode: onToggleDarkMode,
      ),
    );
  }
}

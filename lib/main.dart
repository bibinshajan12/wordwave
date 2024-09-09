import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Make sure the HomeScreen is imported

void main() {
  runApp(const WordWaveApp());
}

class WordWaveApp extends StatelessWidget {
  const WordWaveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordWave', // The title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // App-wide theme settings
      ),
      home: HomeScreen(), // The starting screen of the app
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

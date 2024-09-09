import 'package:flutter/material.dart';
import 'category_selection_screen.dart'; // Import the category selection screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to CategorySelectionScreen when button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategorySelectionScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Updated to backgroundColor
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Button size
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Text style
          ),
          child: Text('Play'),
        ),
      ),
    );
  }
}

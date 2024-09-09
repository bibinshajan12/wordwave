import 'package:flutter/material.dart';
import '../widgets/hangman_widget.dart'; // Import the game screen (HangmanGameScreen)

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Category'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryButton(category: 'Animals'),
            CategoryButton(category: 'Fruits'),
            CategoryButton(category: 'Countries'),
            CategoryButton(category: 'Technology'),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;

  const CategoryButton({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the HangmanGameScreen when a category is selected
          print('Category selected: $category'); // Debugging: Check if button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HangmanGameScreen(category: category), // Pass category to the game screen
            ),
          );
        },
        child: Text(category),
      ),
    );
  }
}

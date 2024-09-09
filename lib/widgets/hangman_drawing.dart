import 'package:flutter/material.dart';

class HangmanDrawing extends StatelessWidget {
  final int wrongGuesses;

  const HangmanDrawing({Key? key, required this.wrongGuesses}) : super(key: key);

  // Helper function to draw the different parts of the hangman
  Widget _buildHangmanPart(int partIndex) {
    switch (partIndex) {
      case 1: // Base
        return const SizedBox(
          height: 20,
          child: Align(alignment: Alignment.centerLeft, child: VerticalDivider(thickness: 8, width: 2)),
        );
      case 2: // Vertical Pole
        return const SizedBox(
          height: 50,
          child: Align(alignment: Alignment.centerLeft, child: VerticalDivider(thickness: 8, width: 2)),
        );
      case 3: // Horizontal Pole
        return const SizedBox(
          width: 70,
          child: Align(alignment: Alignment.topLeft, child: Divider(thickness: 8, height: 2)),
        );
      case 4: // Rope
        return const SizedBox(
          height: 20,
          child: Align(alignment: Alignment.centerLeft, child: VerticalDivider(thickness: 3, width: 2)),
        );
      case 5: // Head
        return const CircleAvatar(radius: 15, backgroundColor: Colors.black);
      case 6: // Body
        return const SizedBox(
          height: 50,
          child: Align(
            alignment: Alignment.topCenter,
            child: VerticalDivider(thickness: 5, width: 2),
          ),
        );
      case 7: // Left Arm
        return Align(
          alignment: Alignment.center,
          child: Container(height: 2, width: 30, color: Colors.black, transform: Matrix4.rotationZ(0.5)),
        );
      case 8: // Right Arm
        return Align(
          alignment: Alignment.center,
          child: Container(height: 2, width: 30, color: Colors.black, transform: Matrix4.rotationZ(-0.5)),
        );
      case 9: // Left Leg
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(height: 2, width: 30, color: Colors.black, transform: Matrix4.rotationZ(0.5)),
        );
      case 10: // Right Leg
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(height: 2, width: 30, color: Colors.black, transform: Matrix4.rotationZ(-0.5)),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(wrongGuesses, (index) => _buildHangmanPart(index + 1)),
    );
  }
}

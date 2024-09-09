import 'package:flutter/material.dart';
import '../screens/hangman_game.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HangmanGameScreen extends StatefulWidget {
  final String category;

  const HangmanGameScreen({Key? key, required this.category}) : super(key: key);

  @override
  _HangmanGameScreenState createState() => _HangmanGameScreenState();
}

class _HangmanGameScreenState extends State<HangmanGameScreen> with SingleTickerProviderStateMixin {
  late HangmanGame _hangmanGame;
  late ConfettiController _confettiController;
  bool _showSmileyRain = false;
  final int maxAttempts = 6; // Set the max number of wrong guesses allowed

  @override
  void initState() {
    super.initState();
    _hangmanGame = HangmanGame(widget.category); // Initialize the game
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onLetterPressed(String letter) {
    setState(() {
      _hangmanGame.guessLetter(letter);
      if (_hangmanGame.isGameOver()) {
        if (_hangmanGame.isGameWon()) {
          _confettiController.play(); // Show confetti when winning
        } else {
          setState(() {
            _showSmileyRain = true; // Show smiley rain when losing
          });
        }
      }
    });
  }

  Widget _buildLetterButton(String letter) {
    return ElevatedButton(
      onPressed: _hangmanGame.isGameOver() ? null : () => _onLetterPressed(letter),
      child: Text(letter),
    );
  }

  Widget _buildWordDisplay() {
    return Text(
      _hangmanGame.getWordToDisplay(),
      style: const TextStyle(fontSize: 36, letterSpacing: 6),
    );
  }

  Widget _buildSmileyRain() {
    if (!_showSmileyRain) return const SizedBox.shrink(); // Don't show until game is lost

    // Generate falling smileys
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 400),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: List.generate(20, (index) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('😢', style: TextStyle(fontSize: 40)),
            );
          }),
        ),
      ),
    );
  }

  // Hangman parts with animation
  Widget _buildHangman() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Base
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 10,
              width: 100,
              color: Colors.brown,
            ),
          ),
          // Vertical Pole
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 150,
              width: 10,
              color: Colors.brown,
              margin: const EdgeInsets.only(top: 10),
            ),
          ),
          // Horizontal Pole
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 3 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 10,
              width: 80,
              color: Colors.brown,
              margin: const EdgeInsets.only(bottom: 140),
            ),
          ),
          // Rope
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 4 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 30,
              width: 3,
              color: Colors.black,
              margin: const EdgeInsets.only(bottom: 120),
            ),
          ),
          // Head
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 5 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(bottom: 80),
            ),
          ),
          // Body
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 6 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 70,
              width: 5,
              color: Colors.black,
              margin: const EdgeInsets.only(bottom: 30),
            ),
          ),
          // Left Arm
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 7 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 2,
              width: 50,
              color: Colors.black,
              margin: const EdgeInsets.only(bottom: 50, left: 25),
            ),
          ),
          // Right Arm
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 8 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 2,
              width: 50,
              color: Colors.black,
              margin: const EdgeInsets.only(bottom: 50, right: 25),
            ),
          ),
          // Left Leg
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 9 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 2,
              width: 50,
              color: Colors.black,
              margin: const EdgeInsets.only(top: 50, left: 25),
            ),
          ),
          // Right Leg
          AnimatedOpacity(
            opacity: _hangmanGame.wrongGuesses >= 10 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 2,
              width: 50,
              color: Colors.black,
              margin: const EdgeInsets.only(top: 50, right: 25),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int attemptsLeft = maxAttempts - _hangmanGame.wrongGuesses; // Calculate attempts left

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman Game'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHangman(), // Hangman drawing in the center
                const SizedBox(height: 20),
                _buildWordDisplay(),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: 'abcdefghijklmnopqrstuvwxyz'.split('').map(_buildLetterButton).toList(),
                ),
                const SizedBox(height: 20),
                if (_hangmanGame.isGameOver())
                  Text(
                    _hangmanGame.isGameWon() ? 'You Win!' : 'Game Over!',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (_hangmanGame.isGameOver())
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hangmanGame.resetGame();
                        _showSmileyRain = false; // Reset smiley rain
                      });
                    },
                    child: const Text('Play Again'),
                  ),
              ],
            ),
          ),
          // Confetti for winning
          if (_hangmanGame.isGameOver() && _hangmanGame.isGameWon())
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 30,
                gravity: 0.3,
              ),
            ),
          _buildSmileyRain(),
        ],
      ),
    );
  }
}

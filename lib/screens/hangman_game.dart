import 'dart:math';
import '../word_lists.dart'; // Import word lists

class HangmanGame {
  late String _selectedWord;
  List<String> _guessedLetters = [];
  int _wrongGuesses = 0;
  late List<String> _wordList;

  // Constructor that takes the category and selects a word from that category
  HangmanGame(String category) {
    _wordList = getWordsForCategory(category);
    _startNewGame();
  }

  // Start a new game by selecting a random word from the category
  void _startNewGame() {
    _selectedWord = _wordList[Random().nextInt(_wordList.length)];
    _guessedLetters.clear();
    _wrongGuesses = 0;
  }

  String getWordToDisplay() {
    return _selectedWord.split('').map((letter) {
      return _guessedLetters.contains(letter) ? letter : '_';
    }).join(' ');
  }

  bool guessLetter(String letter) {
    if (_selectedWord.contains(letter)) {
      _guessedLetters.add(letter);
      return true;
    } else {
      _wrongGuesses++;
      return false;
    }
  }

  bool isGameOver() {
    return _wrongGuesses >= 6 || isGameWon();
  }

  bool isGameWon() {
    return _selectedWord.split('').every((letter) => _guessedLetters.contains(letter));
  }

  int get wrongGuesses => _wrongGuesses;

  void resetGame() {
    _startNewGame();
  }
}

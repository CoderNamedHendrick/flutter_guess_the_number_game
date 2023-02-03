import 'dart:core';
import 'dart:math';

class Game {
  int _randomGuess;
  int _totalScore;
  int _roundScore;

  int get score => _totalScore;

  int get guess => _randomGuess;

  int get roundScore => _roundScore;

  Game._(this._randomGuess, [this._roundScore = 0, this._totalScore = 0]);

  factory Game() {
    return Game._(0, 0, 0)..newGame();
  }

  factory Game.initTest(int randomGuess) {
    return Game._(randomGuess);
  }

  void newGame([int? testValue]) {
    _roundScore = 0;
    _randomGuess = testValue ?? (Random().nextInt(100) + 1);
  }

  void reset([int? testValue]) {
    newGame(testValue);
    _totalScore = 0;
  }

  void submitGuess(int guess) {
    final difference = guess - _randomGuess;

    if (difference == 0) {
      _roundScore = 200;
    } else {
      _roundScore = 100 - difference.abs();
    }

    _totalScore += roundScore;
  }
}

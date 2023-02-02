import 'package:flutter_test/flutter_test.dart';
import 'package:guess_the_number_flutter/model/game.dart';

void main() {
  group('Game model tests', () {
    late Game game;
    setUp(() => game = Game.initTest(30));

    test(
      'Ensure an instance of Game returns zero score and random number is 30',
      () {
        expect(game.score, 0);
        expect(game.guess, 30);
      },
    );

    test('Calculating user score', () {
      game.submitGuess(50);
      expect(game.score, 80);

      game.submitGuess(29);
      expect(game.score, 179);

      game.submitGuess(30);
      expect(game.score, 379);
    });

    test('Round score update', () {
      game.submitGuess(50);
      expect(game.score, 80);

      game.submitGuess(29);
      expect(game.score, 179);

      game.newGame(10);

      expect(game.roundScore, 0);
    });

    test('Run multiple games', () {
      game.submitGuess(20); // score: 90
      expect(game.score, 90);

      game.newGame(20);

      game.submitGuess(40); // 80
      expect(game.score, 170);
    });

    test('Run multiple games reset and start again', () {
      game.submitGuess(50);
      game.submitGuess(29);
      expect(game.score, 179);

      game.reset(80);

      expect(game.score, 0);

      game.submitGuess(40);
      game.submitGuess(80);
      expect(game.score, 260);
    });
  });
}

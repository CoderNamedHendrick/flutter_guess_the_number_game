import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_the_number_flutter/model/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Guess the number game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final game = Game();
  final guessController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      game.reset();
                      setState(() {});
                    },
                    child: const Text('Reset Game'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      '🎯🎯Total Score:',
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      '${game.score}',
                      style: const TextStyle(fontSize: 28, color: Colors.amber),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'I\'m guessing a number between 1 and 100.\n Take a guess👀',
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: guessController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp('[\\D]'), allow: false),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Guess',
                  ),
                  validator: (value) {
                    if (value == null) return null;

                    if (value.isEmpty) return 'Please input a number';

                    if (int.parse(value) > 100) {
                      return 'Guess out of bounds, please try again';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 12),
                MaterialButton(
                  onPressed: () {
                    final valid = key.currentState!.validate();

                    if (valid) {
                      game.submitGuess(int.parse(guessController.text));
                      showSuccessDialog();
                    }
                  },
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  child: const Text('Submit Guess'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text(
            'Congratulations🎉🎉🎉, I guessed ${game.guess}.\nYou scored ${game.roundScore} in this round and your total score is ${game.score}',
            style: const TextStyle(fontSize: 26, color: Colors.blueAccent),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                game.newGame();
                guessController.clear();
                setState(() {});
              },
              child: const Text('Continue to new round'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                game.reset();
                guessController.clear();
                setState(() {});
              },
              child: const Text('Reset game'),
            ),
          ],
        );
      },
    );
  }
}

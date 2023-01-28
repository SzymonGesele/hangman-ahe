import 'package:flutter/material.dart';
import 'package:hangman/screen/start_screen.dart';

void main() async {
  runApp(const HangMan());
}

class HangMan extends StatelessWidget {
  const HangMan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const StartScreen(),
    );
  }
}



import 'package:flutter/material.dart';
import 'game_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  
  @override
  State<StartScreen> createState() => _StartScreenState();
}




class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hangman: The Game"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Start"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
          },
        ),
      ),
    );
  }

}
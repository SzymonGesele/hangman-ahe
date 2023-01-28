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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: const Text("Hangman: The Game"),
        //   centerTitle: true,
        //   elevation: 0.0,
        //   backgroundColor: Colors.transparent,
        // ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Image.asset("assets/images/logo_normal.png", height: 100),
              const SizedBox(height: 50),
              Image.asset("assets/images/start_screen.png"),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: -10,
                          blurRadius: 40,
                          offset: const Offset(0, 12), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Rozpocznij grę',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18, // shadows:
                        ),

                      ),

                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:hangman/consts/consts.dart';
import 'package:hangman/game/figure_widget.dart';
import 'package:hangman/game/letter_widget.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

enum ColorType { text, background, border }


class _GameScreenState extends State<GameScreen> {
  List<String> steps = [GameUI.step_0, GameUI.step_1, GameUI.step_2, GameUI.step_3, GameUI.step_4, GameUI.step_5, GameUI.step_6, GameUI.step_7];
  String characters = GameUI.characters.toUpperCase();
  String word = "";
  List<String> selectedChar = [];
  int tries = 0;
  bool isWinner = false;


  @override
  void initState() {
    super.initState();
    List<String> words = GameWords.words;
    var random = Random.secure();
    int randomIndex = random.nextInt(words.length);
    return setState(() {
      word = words[randomIndex];
    });
  }


  bool userWon() {
    for (String letter in word.toUpperCase().replaceAll(RegExp(r'\s+'), '').split("")) {
      if (!selectedChar.contains(letter)) {
        return false;
      }
    }
    return true;
  }

  Color getColor(String letter, ColorType colorType) {
    bool isSelected = selectedChar.contains(letter.toUpperCase());
    bool isCorrect = word.toUpperCase().split("").contains(letter.toUpperCase());

    switch(colorType){
      case ColorType.text:
        return isSelected && isCorrect ? const Color(0xFF66BB6A) : isSelected && !isCorrect ? const Color(0xFFE53935) : Colors.white;
      case ColorType.background:
        return isSelected ? Colors.transparent : Colors.black87;
      case ColorType.border:
        return isSelected && isCorrect ? const Color(0xFF66BB6A) : isSelected && !isCorrect ? const Color(0xFFE53935) : Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 25),
          title: Image.asset('assets/images/logo_small.png', fit: BoxFit.cover, height: 45,),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Center(
                        child: Stack(
                          children: [
                            figure(steps[tries]),
                          ],
                        )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: word
                            .split(" ")
                            .map((word) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: word
                              .split("")
                              .map((e) => letter(
                              e, tries == 7 ? false : !selectedChar.contains(e.toUpperCase())))
                              .toList(),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: tries < 7 && !isWinner,
                child: Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.count(
                        crossAxisCount: 7,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: characters.split("").map((e) {
                          return GestureDetector(
                              onTap: selectedChar.contains(e.toUpperCase())
                                  ? null
                                  : () {
                                setState(() {

                                  selectedChar.add(e.toUpperCase());
                                  if (!word.toUpperCase()
                                      .split("")
                                      .contains(e.toUpperCase())) {
                                    if(tries <= 7) {
                                      tries++;
                                    }
                                  }
                                  isWinner = userWon();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: getColor(e, ColorType.background),
                                  border:  Border.all(color: getColor(e, ColorType.border), width: 3),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold, color: getColor(e, ColorType.text)
                                  ),
                                ),
                              )));
                        }).toList(),
                      ),
                    ))),
            Visibility(
                visible: tries == 7,
                child: Expanded(
                    flex: 3,
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Column(
                              children: [
                                Image.asset("assets/images/error.png", height: 100),
                                const Text("Przegra??e??...",style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                )),
                                const SizedBox(height: 15),
                                const Text("Chcesz si?? zrewan??owa???",style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                )),
                                const SizedBox(height: 55),
                                Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GameScreen()));
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
                                          'Zacznij od nowa',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18, // shadows:
                                          ),

                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    )
                )
            ),
            Visibility(
                visible: isWinner,
                child: Expanded(
                    flex: 3,
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Column(
                              children: [
                                Image.asset("assets/images/success.png", height: 100),
                                const Text("Gratulacje! Wygra??e??.",style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                )),
                                const SizedBox(height: 15),
                                const Text("Gotowy na kolejn?? rund???",style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                )),
                                const SizedBox(height: 55),
                                Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GameScreen()));
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
                                          'Zacznij od nowa',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18, // shadows:
                                          ),

                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}



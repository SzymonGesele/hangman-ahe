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
    var words = GameWords.words;
    var random = Random.secure();
    var randomIndex = random.nextInt(words.length);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Hangman: The Game"),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                figure(steps[tries], tries >= 0 && tries <= 7),
                              ],
                            )),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              '${7 - tries}',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          return ElevatedButton(
                              onPressed: selectedChar.contains(e.toUpperCase())
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
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0)))),
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ));
                        }).toList(),
                      ),
                    ))),
            Visibility(
                visible: tries == 7,
                child: Expanded(
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left:15, bottom: 20, right: 20, top:10), //apply padding to some sides only
                                      child: Text("GAME OVER",style: TextStyle(
                                        fontSize: 20,
                                      )),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  child: const Text("Zacznij od nowa"),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GameScreen()));                            },
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
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left:15, bottom: 20, right: 20, top:10), //apply padding to some sides only
                                      child: Text("Super, Wygrywasz !",style: TextStyle(
                                        fontSize: 20,
                                      )),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  child: const Text("Nowa gra"),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GameScreen()));                            },
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



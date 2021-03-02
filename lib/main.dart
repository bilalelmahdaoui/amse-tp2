import 'package:fifteen_puzzle_game/ex05B.dart';
import 'package:fifteen_puzzle_game/ex06A.dart';
import 'package:fifteen_puzzle_game/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'ex01.dart';
import 'ex02.dart';
import 'ex02A.dart';
import 'ex03.dart';
import 'ex04.dart';
import 'ex05.dart';
import 'ex05A.dart';
import 'ex06.dart';
import 'game.dart';
import 'ex07.dart';

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TP2 - Bilal El Mahdaoui", home: MyApp(),
        theme: ThemeData(
          //brightness: Brightness.dark,
          fontFamily: 'Hind',
        )
    )
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TP2")),
      body: SafeArea(
        child: ListView(
            children: [
              GameTile(),
              ExerciceTile("Exercice 01", "Afficher une image", ExOne()),
              ExerciceTile("Exercice 02", "Transformer une image", ExTwo()),
              ExerciceTile("Exercice 02", "Animer et Transformer une image", ExTwoA()),
              ExerciceTile("Exercice 03", "Menu et navigation entre pages", ExThree()),
              ExerciceTile("Exercice 04", "Affichage d'une tuile (un morceau d'image) ", ExFour()),
              ExerciceTile("Exercice 05", "Génération du plateau de tuiles", ExFive()),
              ExerciceTile("Exercice 05a", "Génération du plateau de tuiles", ExFiveA()),
              ExerciceTile("Exercice 05b", "Génération du plateau de tuiles", ExFiveB()),
              ExerciceTile("Exercice 06", "Animation d'une tuile", ExSix()),
              ExerciceTile("Exercice 06a", "Animation d'une tuile", ExSixA()),
              ExerciceTile("Exercice 07", "Jeu de taquin", ExSeven()),
            ]),
      ),
    );
  }
}

class ExerciceTile extends StatelessWidget {

  String exerciceTitle;
  String exerciceSubTitle;
  Widget exerciceWidget;
  ExerciceTile(this.exerciceTitle, this.exerciceSubTitle, this.exerciceWidget);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.apps_rounded),
        title: Text(exerciceTitle),
        subtitle: Text(exerciceSubTitle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => exerciceWidget),
          );
        },
      ),
    );
  }
}

class GameTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Color(0xff152238),
        leading: Icon(Icons.done, color: Colors.white,),
        title: Text("Final Project", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        subtitle: Text("Jeu de Taquin", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Game()),
          );
        },
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {

  Widget firstButton;
  Widget secondButton;
  bool isGame;

  BottomButtons(this.firstButton, this.secondButton, [this.isGame = false]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children : buildButtons(context)
        ),
      );
  }

  List<Widget> buildButtons(BuildContext context) {
    if (this.firstButton == null) return <Widget>[NextExercice(secondButton, isGame)];
    if (this.secondButton == null) return <Widget>[PreviousExercice(firstButton)];
    return [PreviousExercice(firstButton), NextExercice(secondButton, isGame)];
  }
}

class NextExercice extends StatelessWidget {

  Widget nextExerciceWidget;
  bool isGame;
  NextExercice(this.nextExerciceWidget, this.isGame);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: isGame ? Text('Go to Exercice 01') : Text('Next Exercice!'),
      color: isGame ? Color(0xff152238) : Colors.blue,
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextExerciceWidget),
        );
      },

    );
  }
}

class PreviousExercice extends StatelessWidget {

  Widget previousExerciceWidget;
  PreviousExercice(this.previousExerciceWidget);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text('Previous Exercice!'),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => previousExerciceWidget),
          );
        },
    );
  }
}

double roundDouble(double value, int places){
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
import 'package:fifteen_puzzle_game/ex03.dart';
import 'package:fifteen_puzzle_game/ex05.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ExFour extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Exercice 04"),
        ),
        persistentFooterButtons: [BottomButtons(ExThree(), ExFive(), false)],
        body: Container(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: Column(
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    heightFactor: 0.45,
                    widthFactor: 0.45,
                    child: buildImage(context),
                  ),
                ),
                SizedBox(height: 20,),
                buildImage(context),
              ])
      )
    );
  }

  Widget buildImage(BuildContext context) {
    return Image.network("https://i.imgur.com/tW2gbUK.png");
  }
}
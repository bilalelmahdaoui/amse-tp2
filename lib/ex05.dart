import 'package:fifteen_puzzle_game/ex04.dart';
import 'package:fifteen_puzzle_game/ex05A.dart';
import 'package:flutter/material.dart';
import 'main.dart';


class ExFive extends StatelessWidget {
  static const String _title = 'Exercice 05';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      persistentFooterButtons: [BottomButtons(ExFour(), ExFiveA(), false)],
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: DisplayGrid(),
        ),
    );
  }
}

class DisplayGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      crossAxisCount: 3,
      children : List.generate(9, (i) => TileWidget("Tile " + i.toString(), Colors.blue[100*(i+1)], (i>=3 && i<=5) ? Colors.blue[100*(i-2)] : Colors.blue[100*(8-i+1)])),
    );
  }
}

class TileWidget extends StatelessWidget {

  String title;
  Color color;
  Color textColor;

  TileWidget(this.title, this.color, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),)),
      color: color,
    );
  }
}


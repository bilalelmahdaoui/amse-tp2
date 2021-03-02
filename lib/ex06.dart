import 'package:fifteen_puzzle_game/ex05B.dart';
import 'package:fifteen_puzzle_game/ex06A.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'main.dart';

// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  Color color;

  Tile(this.color);
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        color: tile.color,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}

class ExSix extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ExSixState();
}

class ExSixState extends State<ExSix> {
  List<Widget> tiles = List<Widget>.generate(2, (index) => TileWidget(Tile.randomColor()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [BottomButtons(ExFiveB(), ExSixA())],
      appBar: AppBar(
        title: Text('Exercice 06'),
        centerTitle: true,
      ),
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
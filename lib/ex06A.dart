import 'package:fifteen_puzzle_game/ex06.dart';
import 'package:fifteen_puzzle_game/ex07.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'main.dart';

math.Random random = new math.Random();

class ExSixA extends StatefulWidget {

  @override
  _ExSixAState createState() => _ExSixAState();
}

class _ExSixAState extends State<ExSixA> {

  static int randomInt;
  List<TileWidget> tiles;

  init() {
    randomInt = random.nextInt(16);
    tiles = List<TileWidget>.generate(
        16, (index) =>
        TileWidget(
          tileId: index,
          isEmpty: (randomInt == index),
        )
    );
  }

  _ExSixAState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [BottomButtons(ExSix(), ExSeven())],
      appBar: AppBar(
        title: Text('Exercice 06 - A'),
        centerTitle: true,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 4,
        children: List.generate(16, (i) =>
            InkWell(
              child: Container(
                child: tiles[i],
                decoration : BoxDecoration(
                  color: (randomInt == i) ? Colors.white : Color(0xffd3d3d3),
                  border: clickable(i)
                      ? Border.all(color: Colors.blue, width: 5)
                      : null,
                ),
              ),
              onTap: () => swapTiles(i, randomInt),
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh), onPressed: () {
        setState(() {
          init();
        });
      },
      ),
    );
  }

  clickable(int index) {
    return (
        (randomInt != index) &&
            (
                ((randomInt % 4 != 0) && (index + 1 == randomInt)) ||
                    (((randomInt + 1) % 4 != 0) && (index - 1 == randomInt)) ||
                    (((randomInt + 4 >= 0) && (index + 4 == randomInt))) ||
                    (((randomInt + 4 < 16) && (index - 4 == randomInt)))
                        && (randomInt != index)
            )
    );
  }


  swapTiles(int tileId, int emptyId) {
    setState(() {
      //print("clicked - tileId : " + tileId.toString() + " - emptyId : " + emptyId.toString());
      if (clickable(tileId)) {
        TileWidget tempTile = tiles[tileId];
        tiles[tileId] = tiles[emptyId];
        tiles[emptyId] = tempTile;
        randomInt = tileId;
      }
    });
  }

}


class TileWidget extends StatelessWidget {

  int tileId;
  bool isEmpty;
  TileWidget({this.tileId, this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        child: Center(
          child: Text(
            (isEmpty ? "Empty " : "Tile ") + (tileId+1).toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),),
        ));
  }
}
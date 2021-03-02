import 'package:fifteen_puzzle_game/ex06A.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'game.dart';
import 'main.dart';

math.Random random = new math.Random();

class ExSeven extends StatefulWidget {

  @override
  _ExSevenState createState() => _ExSevenState();
}

class _ExSevenState extends State<ExSeven> {

  static int randomInt;
  List<TileWidget> tiles;
  int sliderValue = 4;
  bool gameStarted = false;

  init() {
    randomInt = random.nextInt(math.pow(sliderValue, 2));
    tiles = List<TileWidget>.generate(
        math.pow(sliderValue, 2), (index) =>
        TileWidget(
          tileId: index,
          isEmpty: (randomInt == index),
          fontValue: sliderValue,
        )
    );
  }

  _ExSevenState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [BottomButtons(ExSixA(), Game())],
      appBar: AppBar(
        title: Text('Exercice 07'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: (sliderValue > 5) ? 12.0-sliderValue : 10.0-sliderValue,
              mainAxisSpacing: (sliderValue > 5) ? 12.0-sliderValue : 10.0-sliderValue,
              crossAxisCount: sliderValue,
              children: List.generate(tiles.length, (i) =>
                  InkWell(
                    child: Container(
                      child: tiles[i],
                      decoration : BoxDecoration(
                        color: (randomInt == i) ? Colors.white : Color(0xffd3d3d3),
                        border: (clickable(i) && gameStarted)
                            ? Border.all(color: Colors.blue, width: 12.0-sliderValue)
                            : null,
                      ),
                    ),
                    onTap: () => swapTiles(i, randomInt),
                  )
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                child: Icon(gameStarted ? Icons.stop_rounded : Icons.play_arrow_rounded),
                onPressed: () {
                  setState(() {
                    gameStarted = !gameStarted;
                  });
                },
              ),
              !gameStarted ? FloatingActionButton(
                heroTag: "btn2",
                child: Icon(Icons.refresh_rounded),
                onPressed: () {
                  setState(() {
                    init();
                  });
                },
              ) : Container(),
            ],
          ),
          !gameStarted ? Slider(
            value: sliderValue.toDouble(),
            min: 2,
            max: 10,
            divisions: 8,
            label: math.pow(sliderValue, 2).toString(),
            onChanged: (double value) {
              setState(() {
                sliderValue = value.toInt();
                init();
              });
            },
          ) : SizedBox(height: 20,),
        ]),
    );
  }

  clickable(int index) {
    return (
        (randomInt != index) &&
            (
                ((randomInt % sliderValue != 0) && (index + 1 == randomInt)) ||
                    (((randomInt + 1) % sliderValue != 0) && (index - 1 == randomInt)) ||
                    (((randomInt + sliderValue >= 0) && (index + sliderValue == randomInt))) ||
                    (((randomInt + sliderValue < math.pow(sliderValue, 2)) && (index - sliderValue == randomInt)))
                        && (randomInt != index)
            )
    );
  }

  swapTiles(int tileId, int emptyId) {
    setState(() {
      if (clickable(tileId) && gameStarted) {
        TileWidget tempTile = tiles[tileId];
        tiles[tileId] = tiles[emptyId];
        tiles[emptyId] = tempTile;
        randomInt = tileId;
      }
    });
  }
}

// ============================

class TileWidget extends StatelessWidget {

  int tileId;
  bool isEmpty;
  int fontValue;
  TileWidget({this.tileId, this.isEmpty, this.fontValue});

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
        child: Center(
          child: Text(
            (isEmpty ? "" : (tileId+1).toString()),
            style: TextStyle(
                fontSize: (24.0-(fontValue == null ? 4 : fontValue)).toDouble(),
                fontWeight: FontWeight.bold, color: Colors.black),),
        ));
  }
}
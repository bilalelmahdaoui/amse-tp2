import 'package:fifteen_puzzle_game/ex07.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'ex01.dart';
import 'main.dart';

math.Random random = new math.Random();

class Game extends StatefulWidget {

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  Color mainColor = Color(0xff152238);
  int slidesCounter = 0;
  static int emptyIdx;
  List<TileWidget> tiles;
  int tilesSliderValue = 3;
  int gameDifficultySliderValue = 1;
  bool gameStarted = false;
  bool displayOriginalImage = false;
  bool isShuffling = false;
  static List<String> images = [
    "https://i.imgur.com/OXXng6N.jpg",
    "https://i.imgur.com/x2bjFt4.png",
    "https://i.imgur.com/rmyd88D.png",
    "https://i.imgur.com/afBd8zP.png",
    "https://i.imgur.com/JKy6K2x.png",
    "https://i.imgur.com/5D8pezz.png",
    "https://i.imgur.com/n8CYubM.png",
    "https://i.imgur.com/BVM3GHs.png",
    /*"https://i.imgur.com/iDMDsjC.png",*/
    "https://i.imgur.com/4JOzF4M.png",
    "https://i.imgur.com/qSWBJaU.png",
    "https://i.imgur.com/38ls34H.png",
    "https://i.imgur.com/NI7Mt7e.png",
    "https://i.imgur.com/ghGgtkm.png",
    "https://i.imgur.com/IB0s80M.png",
    "https://i.imgur.com/rZLM4Vt.png",
    "https://i.imgur.com/rl7HKsu.png",
    "https://i.imgur.com/Hd3VQQJ.png",
    "https://i.imgur.com/YAxMrdI.png",
    "https://i.imgur.com/r7nNGsB.png",
    "https://i.imgur.com/iMgjN73.png",
  ];
  String imageURL = images[random.nextInt(images.length)];

  initImageTiles() {
    //print("initImageTiles executed...");
    emptyIdx = random.nextInt(math.pow(tilesSliderValue, 2));
    tiles = List.generate(
        tilesSliderValue, (j) => List.generate(
        tilesSliderValue, (i) => TileWidget(
            gameStarted: gameStarted,
            imageURL: imageURL,
            tileId: i+(j*tilesSliderValue),
            isEmpty: emptyIdx == i+(j*tilesSliderValue),
            tilesSliderValue: tilesSliderValue,
            alignment: Alignment(
                -1+i*(2)/(tilesSliderValue-1),
                -1+j*(2)/(tilesSliderValue-1)
            )
    ))).expand((i) => i).toList();
  }

  @override
  void initState() {
    super.initState();
    initImageTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [BottomButtons(null, ExOne(), true)],
      appBar: AppBar(
        title: Text('Jeu de Taquin'),
        backgroundColor: mainColor,
        centerTitle: true,
        brightness: Brightness.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // ========================== [-------------] ========================== //
          // ========================== [Image & Tiles] ========================== //
          // ========================== [-------------] ========================== //

            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width-20,
              ),
              child: Container(
                //decoration: new BoxDecoration(color: Colors.red,),
                child: displayOriginalImage ?
                      Container(child: Image.network(imageURL), padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), alignment: Alignment.center)
                    : Tiles(tilesSliderValue: tilesSliderValue, tiles: tiles, swapTiles: swapTiles),
                //child: Text("helloworld"),
              )
            ),

          // ========================== [-------------------] ========================== //
          // ========================== [Bottom control area] ========================== //
          // ========================== [-------------------] ========================== //

            Container(
              child: Column(
                children: [
                  // Start & Shuffle Button
                  !gameStarted ? SizedBox(
                    child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                        backgroundColor: mainColor,
                        heroTag: "startButton",
                          child: Icon(Icons.play_arrow_rounded),
                          onPressed: startGame,
                        ),
                        FloatingActionButton(
                        backgroundColor: mainColor,
                        heroTag: "shuffleButton",
                          child: Icon(Icons.shuffle_rounded),
                          onPressed: chooseAnotherImage,
                        )
                      ],
                    ),
                  ) :
                  (displayOriginalImage ? Container() :
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor: mainColor,
                        heroTag: "stopButton",
                        child: Icon(Icons.stop_rounded),
                        onPressed: endGame,
                      ),
                      FloatingActionButton(
                        backgroundColor: mainColor,
                        heroTag: "restartButton",
                        child: Icon(Icons.refresh_rounded),
                        onPressed: () => {
                          initImageTiles(),
                          shuffleTiles(),
                        },
                      )
                    ],
                  )),
                  // ========================== [-------] ========================== //
                  // ========================== [Sliders] ========================== //
                  // ========================== [-------] ========================== //
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 65
                          ),
                          child: gameStarted ?
                          Container(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              child: Text(
                                "Click to " + (displayOriginalImage ? "hide" : "see") + " original image!",
                                style: TextStyle(color: displayOriginalImage ? Colors.black : Colors.white),
                              ),
                              color: displayOriginalImage ? null : mainColor ,
                              onPressed: () {
                                setState(() {
                                  displayOriginalImage = !displayOriginalImage;
                                });
                              },
                            ),
                          ) : Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width*0.3 - 20,
                                      child: Text("Divisions", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    height: 30,
                                    width: MediaQuery.of(context).size.width*0.7 - 20,
                                    child: Slider(
                                      activeColor: mainColor,
                                      inactiveColor: mainColor.withOpacity(0.2),
                                      value: tilesSliderValue.toDouble(),
                                      min: 2,
                                      max: 6,
                                      divisions: 4,
                                      label: math.pow(tilesSliderValue, 2).toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          tilesSliderValue = value.toInt();
                                          initImageTiles();
                                        });
                                      },
                                    ),
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width*0.3 - 20,
                                      child: Text("Difficulty", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)),
                                  Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 20,
                                      width: MediaQuery.of(context).size.width*0.70 - 20,
                                    child: Slider(
                                      activeColor: getDifficultyColor(gameDifficultySliderValue),
                                      inactiveColor: getDifficultyColor(gameDifficultySliderValue).withOpacity(0.2),
                                      value: gameDifficultySliderValue.toDouble(),
                                      min: 1,
                                      max: 3,
                                      divisions: 2,
                                      label: showDifficultyLabel(gameDifficultySliderValue),
                                      onChanged: (double value) {
                                        setState(() {
                                          gameDifficultySliderValue = value.toInt();
                                        });
                                      },
                                    )
                                  ),
                                ]
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ), // (Buttons & Sliders)
          ]
      ),
    );
  }


  getDifficultyColor(int level) {
    switch(level) {
      case 1: return Colors.green;
      case 2: return mainColor;
      case 3: return Colors.red;
    }
  }

  showDifficultyLabel(int level) {
    switch(level) {
      case 1: return "Easy";
      case 2: return "Normal";
      case 3: return "Hard";
    }
  }

  showNonEmptyTile(i) {
    TileWidget tempWidget = tiles[i];
    tempWidget.isEmpty = false;
    return tempWidget;
  }

  clickable(int index) {
    //print("clickable executed...");
    bool isClickable =
    (
        (emptyIdx != index) &&
            (
                ((emptyIdx % tilesSliderValue != 0) && (index + 1 == emptyIdx)) ||
                    (((emptyIdx + 1) % tilesSliderValue != 0) && (index - 1 == emptyIdx)) ||
                    (((emptyIdx + tilesSliderValue >= 0) && (index + tilesSliderValue == emptyIdx))) ||
                    (((emptyIdx + tilesSliderValue < math.pow(tilesSliderValue, 2)) && (index - tilesSliderValue == emptyIdx)))
            )
    );
    //print("verifying : " + index.toString() + " : clickable = " + isClickable.toString() + " : emptyIdx = " + emptyIdx.toString());
    return isClickable;
  }


  swapTiles(TileWidget tile) {
    int tileId = tiles.indexOf(tile);
    int emptyTileId = tiles.indexWhere((tile) => tile.isEmpty);
    //print("swapTiles executed || tileId: " + tileId.toString() + " || emptyTileId : " + emptyTileId.toString());
    setState(() {

      if (clickable(tileId) && gameStarted) {
        tiles[tileId] = tiles[emptyTileId];
        tiles[emptyTileId] = tile;
        emptyIdx = tileId;
        if (!isShuffling) {
          slidesCounter++;
          if (verifyTiles()) {
            showDialog(
              context: context,
              builder: (_) => GameDialog(chooseAnotherImage: chooseAnotherImage, slidesCounter: slidesCounter, endGame: endGame),
              barrierDismissible: false,
            );
          }
        }

      }
    });
  }

  chooseAnotherImage() {
    //print("chooseAnotherImage executed...");
    String currentImageURL = imageURL;
    while (currentImageURL == imageURL) {
      setState(() {
        imageURL = images[random.nextInt(images.length)];
      });
    }
    initImageTiles();
  }

  verifyTiles() {
    //print("verifyTiles executed...");
    for (int i=0; i<tiles.length; i++) {
      if (tiles[i].tileId != i && !tiles[i].isEmpty) {
        return false;
      }
    }
    return true;
  }

  endGame() {
    //print("endGame executed...");
    setState(() {
      gameStarted = false;
      initImageTiles();
    });
  }

  shuffleTiles() {
    //print("shuffleTiles executed...");
    int previousEmptyIdx = emptyIdx;
    setState(() {
      isShuffling = true;
      List<TileWidget> slidableTiles = [];
      for(int k=0; k<math.pow(tilesSliderValue, 2)*(gameDifficultySliderValue+1); k++) {
        slidableTiles = tiles.where((tile) => (clickable(tiles.indexOf(tile)) && previousEmptyIdx!=tiles.indexOf(tile))).toList();
        swapTiles(slidableTiles[random.nextInt(slidableTiles.length)]);
      }
      emptyIdx = tiles.indexWhere((tile) => tile.isEmpty);
      isShuffling = false;
    });
  }

  startGame() {
    //print("startGame executed...");
    setState(() {
      slidesCounter = 0;
      gameStarted = true;
      initImageTiles();
      shuffleTiles();
    });
  }

}

class GameDialog extends StatelessWidget {

  VoidCallback chooseAnotherImage;
  VoidCallback endGame;
  int slidesCounter;

  GameDialog({this.chooseAnotherImage, this.slidesCounter, this.endGame});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("You win with " + slidesCounter.toString() + " slides!"),
      content: Text("Would you like to try another image ?"),
      actions: [
        CupertinoDialogAction(
          child: Text("Yes", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),),
          onPressed: () {
            endGame();
            //print("yesss");
            Navigator.of(context).pop();
            chooseAnotherImage();
          },
        ),
        CupertinoDialogAction(
          child: Text("No", style: TextStyle(color: Colors.black54),),
          onPressed: () {
            endGame();
            //print("Nooo");
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


class TileWidget extends StatelessWidget {

  int tileId;
  String imageURL;
  bool isEmpty;
  Alignment alignment;
  int tilesSliderValue;
  bool gameStarted;

  TileWidget({this.tileId, this.imageURL, this.isEmpty, this.tilesSliderValue, this.alignment, this.gameStarted});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Align(
            alignment: alignment,
            heightFactor: 1 / tilesSliderValue,
            widthFactor: 1 / tilesSliderValue,
            child: (isEmpty && gameStarted) ? Container() : Image.network(imageURL),
          ),
        ),
      ),
    );
  }
}

class Tiles extends StatelessWidget {

  int tilesSliderValue;
  List<TileWidget> tiles;
  dynamic swapTiles;


  Tiles({this.tilesSliderValue, this.tiles, this.swapTiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: new BoxDecoration(color: Colors.red,),
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        crossAxisCount: tilesSliderValue,
        children: List.generate(tiles.length, (i) =>
            InkWell(
              child: Container(
                child: tiles[i],
                //child: gameStarted ? tiles[i] : (tiles[i].isEmpty ? showNonEmptyTile(i) : tiles[i]),
              ),
              onTap: () => swapTiles(tiles[i]),
            )
        ),
      ),
    );
  }
}
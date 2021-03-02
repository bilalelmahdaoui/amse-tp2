import 'package:fifteen_puzzle_game/ex05B.dart';
import 'package:flutter/material.dart';
import 'ex05.dart';
import 'main.dart';


class ExFiveA extends StatelessWidget {
  static const String _title = 'Exercice 05-A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      persistentFooterButtons: [BottomButtons(ExFive(), ExFiveB())],
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: GridWidget(),
      ),
    );
  }
}


class GridWidget extends StatelessWidget {

  int nRowsCols = 3;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      crossAxisCount: nRowsCols,
      children: List.generate(
          nRowsCols, (j) => List.generate(
                  nRowsCols, (i) => TileWidget(
                                      Alignment(
                                          -1+i*(2)/(nRowsCols-1),
                                          -1+j*(2)/(nRowsCols-1)
                                      )
                                  )
                      )
                  ).expand((i) => i).toList(),
    );
  }
}

class TileWidget extends StatelessWidget {

  Alignment alignment;
  TileWidget(this.alignment);

  int nRowsCols = 3;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: alignment,
          heightFactor: 1/nRowsCols,
          widthFactor: 1/nRowsCols,
          child: Image.network(
            "https://i.imgur.com/afBd8zP.png"),
        ),
      ),
    );
  }
}



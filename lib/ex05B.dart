import 'package:fifteen_puzzle_game/ex06.dart';
import 'package:flutter/material.dart';
import 'ex05A.dart';
import 'main.dart';
import 'dart:math';


class ExFiveB extends StatefulWidget {
  @override
  _ExFiveBState createState() => _ExFiveBState();
}

class _ExFiveBState extends State<ExFiveB> {

  double _sliderValue = 2;
  static const String _title = 'Exercice 05-B';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      persistentFooterButtons: [BottomButtons(ExFiveA(), ExSix())],
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
            children: [
              Expanded(child: GridWidget(_sliderValue)),
              Slider(
                value: _sliderValue,
                min: 2,
                max: 10,
                divisions: 8,
                label: pow(_sliderValue.toInt(), 2).toString(),
                onChanged: (double value) {
                  setState(() {
                    _sliderValue = value;
                  });
                  },
              ),
            ]
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GridWidget extends StatefulWidget {

  double nRowsCols;
  GridWidget(this.nRowsCols);

  @override
  _GridWidgetState createState() => _GridWidgetState();
}


class _GridWidgetState extends State<GridWidget> {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      crossAxisCount: widget.nRowsCols.toInt(),
      children: List.generate(
          widget.nRowsCols.toInt(), (j) => List.generate(
          widget.nRowsCols.toInt(), (i) => TileWidget(widget.nRowsCols,
          Alignment(
              -1+i*(2)/(widget.nRowsCols-1),
              -1+j*(2)/(widget.nRowsCols-1)
          )
      ))).expand((i) => i).toList(),
    );
  }
}

// ignore: must_be_immutable
class TileWidget extends StatefulWidget {

  Alignment alignment;
  double nRowsCols;
  TileWidget(this.nRowsCols, this.alignment);

  @override
  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: widget.alignment,
          heightFactor: 1/widget.nRowsCols,
          widthFactor: 1/widget.nRowsCols,
          child: Image.network(
              "https://i.imgur.com/OXXng6N.jpg"),
        ),
      ),
    );
  }
}



import 'package:fifteen_puzzle_game/ex02.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ExOne extends StatefulWidget {

  @override
  _ExOneState createState() => _ExOneState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ExOneState extends State<ExOne> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exercice 01")),
        persistentFooterButtons: [BottomButtons(null, ExTwo(), false)],
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Image.network('https://miro.medium.com/max/1920/0*z1mm6izqSeDiKukb'),
      ),
    );
  }
}
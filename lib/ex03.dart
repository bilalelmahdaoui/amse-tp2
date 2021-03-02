import 'package:fifteen_puzzle_game/ex02.dart';
import 'package:fifteen_puzzle_game/main.dart';
import 'package:flutter/material.dart';
import 'ex04.dart';

class ExThree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 03"),
      ),
      persistentFooterButtons: [BottomButtons(ExTwo(), ExFour(), false)],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
                child: Text("Already done ✅", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
        ]
        ),
      ),
    );
  }
}
import 'dart:async';
import 'dart:math';
import 'package:fifteen_puzzle_game/ex02.dart';
import 'package:flutter/material.dart';
import 'ex03.dart';
import 'main.dart';


class ExTwoA extends StatefulWidget {

  @override
  _ExTwoAState createState() => _ExTwoAState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ExTwoAState extends State<ExTwoA> {

  double rotateXSliderValue = 0;
  double rotateZSliderValue = 0;
  double scaleSliderValue = 0;
  bool mirrorValue = false;
  bool animationRunning = false;
  bool rotateXInc = true;
  bool rotateZInc = true;
  bool scaleInc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exercice 02 - A")),
        persistentFooterButtons: [BottomButtons(ExTwo(), ExThree(), false)],
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SingleChildScrollView(
          child: Column(
              children: [
                ConstrainedBox(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Transform.rotate(
                        angle: rotateXSliderValue*pi/100,
                        child: Transform.scale(
                            scale: (1+scaleSliderValue/100),
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateX(rotateZSliderValue*pi/100),
                                child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(mirrorValue ? pi : 0),
                                    child: Image.network('https://miro.medium.com/max/405/1*J9_05FyiiDk2y2hhbOwNlg.png'))))),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 300,
                    minHeight: 300,
                    minWidth: 300,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width*0.30 - 20,
                          child: Text("Rotate X")),
                      Container(
                        width: MediaQuery.of(context).size.width*0.70 - 20,
                        child: Slider(
                          value: rotateXSliderValue,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: (rotateXSliderValue*180/100).round().toString() + "°",
                          onChanged: (double value) {
                            setState(() {
                              rotateXSliderValue = value;
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
                          width: MediaQuery.of(context).size.width*0.30 - 20,
                          child: Text("Rotate Z")),
                      Container(
                        width: MediaQuery.of(context).size.width*0.70 - 20,
                        child: Slider(
                          value: rotateZSliderValue,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: (rotateZSliderValue*180/100).round().toString() + "°",
                          onChanged: (double value) {
                            setState(() {
                              rotateZSliderValue = value;
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
                          width: MediaQuery.of(context).size.width*0.30 - 20,
                          child: Text("Scale")),
                      Container(
                        width: MediaQuery.of(context).size.width*0.70 - 20,
                        child: Slider(
                          value: scaleSliderValue,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: roundDouble(1+scaleSliderValue/100, 2).toString() + "x",
                          onChanged: (double value) {
                            setState(() {
                              scaleSliderValue = value;
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
                          width: MediaQuery.of(context).size.width*0.30 - 20,
                          child: Text("Mirror")),
                      Container(
                        width: MediaQuery.of(context).size.width*0.70 - 20,
                        alignment: Alignment.centerLeft,
                        child: Checkbox(
                            value: mirrorValue,
                            onChanged: (bool value){
                              setState(() {
                                mirrorValue = value;
                              });
                            }
                        ),
                      ),
                    ]
                ),
              ]),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(animationRunning ? Icons.pause_rounded : Icons.play_arrow_rounded),
          onPressed: () => {
            setState(() {
              animationRunning = !animationRunning;
            }),
            Timer.periodic(Duration(milliseconds: 50), animate),
          }
        ),
    );
  }

  void animate(Timer t) {
    const unit = 1;
    setState(() {
      if (!animationRunning) {
        t.cancel();
        return;
      }

      if (rotateXInc) {
        rotateXSliderValue += unit;
        if (rotateXSliderValue == 100) rotateXInc = false;
      }
      else {
        rotateXSliderValue -= unit;
        if (rotateXSliderValue == 0) rotateXInc = true;
      }


      if (rotateZInc) {
        rotateZSliderValue += unit;
        if (rotateZSliderValue == 100) rotateZInc = false;
      }
      else {
        rotateZSliderValue -= unit;
        if (rotateZSliderValue == 0) rotateZInc = true;
      }


      if (scaleInc) {
        scaleSliderValue += unit;
        if (scaleSliderValue == 100) scaleInc = false;
      }
      else {
        scaleSliderValue -= unit;
        if (scaleSliderValue == 0) scaleInc = true;
      }
    });
  }
}
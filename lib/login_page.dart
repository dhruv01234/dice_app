import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'drawer.dart';
class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}
class _loginPageState extends State<loginPage> {
  int upDice = 2;
  int downDice = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      drawerEdgeDragWidth: 50,
      drawerDragStartBehavior: DragStartBehavior.start,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gamepad_rounded,
              color: Colors.red[300],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'DICE',
              style: TextStyle(color: Colors.red[300], fontSize: 25),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red[700],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Image(
                  image: AssetImage('images/dice$upDice.jpg'),
                ),
                onPressed: () {
                  setState(() {
                    upDice = Random().nextInt(6) + 1;
                  });
                },
              ),
              Text(
                'Click On The Dice',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              TextButton(
                child: Image(
                  image: AssetImage('images/dice$downDice.jpg'),
                ),
                onPressed: () {
                  setState(() {
                    downDice = Random().nextInt(6) + 1;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

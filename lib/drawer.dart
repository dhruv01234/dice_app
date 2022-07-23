import 'package:flutter/material.dart';
class sidebar extends StatelessWidget {
  const sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.redAccent
      ),
      child: TextButton(
        onPressed: (){

        },
        child: Text('Home'),
      ),
    );
  }
}

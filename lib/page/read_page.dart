import 'package:flutter/material.dart';

class ReadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(

          ),
          Text(
            '闲读',
            style: TextStyle(fontSize: 32.0),
          ),
        ],
      ),
    );
  }
}

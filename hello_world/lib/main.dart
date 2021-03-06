import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          leading: Text('This is Leading'),
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 96, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

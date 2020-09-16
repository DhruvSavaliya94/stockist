import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stockist/land.dart';


void main() {
  runApp(MyApp()); //"My: Entry point of app "
}

class MyApp extends StatelessWidget {
  // "My: Stateless widget every time created fresh
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

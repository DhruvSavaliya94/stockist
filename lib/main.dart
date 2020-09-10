import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp()); //"My: Entry point of app "
}

class MyApp extends StatelessWidget {
  // "My: Stateless widget every time created fresh
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Stockist"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 52,
                      height: 52,
                      child: Text(
                        "Box 1",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Kumbh'),
                      ),
                      color: Colors.deepOrange,
                    ),
                    Container(
                      width: 52,
                      height: 52,
                      child: Text("Box 2"),
                      color: Colors.amberAccent,
                    ),
                    Container(
                      height: 52,
                      width: 52,
                      child: Icon(Icons.perm_identity),
                    ),
                    Container()
                  ],
                ),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

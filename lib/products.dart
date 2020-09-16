import 'package:flutter/material.dart';

//Forms:  https://codingwithjoe.com/building-forms-with-flutter/
class Products extends StatefulWidget{
  @override
  _ProductsState createState() => _ProductsState();
}
class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Products"),
          backgroundColor: Colors.orangeAccent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

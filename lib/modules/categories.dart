import 'package:flutter/material.dart';
import 'package:stockist/screens/addCat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:stockist/classes.dart';
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<List<Category>> userData;
  void initState(){
    super.initState();
    userData = _getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Category"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context) ,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Category>>(
            future: userData,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: Text(snapshot.data[index].cpid.toString()),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text("Description: ${snapshot.data[index].desc}"),
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return AddCategory();
                  }
              ),
            ).then((value){
              setState(() {
                userData = _getCategory();
              });
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

Future<List<Category>> _getCategory() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllCategory");
  var jsonData = json.decode(data.body);
  List<Category> cust = [];
  for(var u in jsonData["AllCategory"]){
    Category category = Category(u["cpid"], u["name"], u["desc"]);
    cust.add(category);
  }
  return cust;
}
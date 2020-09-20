import 'package:flutter/material.dart';
import 'package:stockist/screens/addSup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:stockist/classes.dart';

class Suppliers extends StatefulWidget {
  @override
  _SuppliersState createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  Future<List<Supplier>> userData;
  void initState(){
    super.initState();
    userData = _getSupplier();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Supplier"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context) ,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Supplier>>(
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
                      leading: Text(snapshot.data[index].sid.toString()),
                      title: Text(snapshot.data[index].sname),
                      subtitle: Text("Address: ${snapshot.data[index].address}\nContact: ${snapshot.data[index].contact}\nGender: ${snapshot.data[index].gender==1 ? "Male" : "Female"}"
                      ),
                      // trailing: Icon(Icons.more_vert),
                      // isThreeLine: true,
                      // onTap: (){
                      // },
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
                    return AddSupplier();
                  }
              ),
            ).then((value){
              setState(() {
                userData = _getSupplier();
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

Future<List<Supplier>> _getSupplier() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllSupplier");
  var jsonData = json.decode(data.body);
  List<Supplier> sup = [];
  for(var u in jsonData["AllSupplier"]){
    Supplier supplier = Supplier(u["sid"], u["sname"], u["address"], u["contact"], u["gender"]);
    sup.add(supplier);
  }
  return sup;
}

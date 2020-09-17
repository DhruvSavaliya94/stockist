import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stockist/classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:stockist/screens/addCust.dart';

//Forms:  https://codingwithjoe.com/building-forms-with-flutter/

class Products extends StatefulWidget{
  @override
  _ProductsState createState() => _ProductsState();
}
class _ProductsState extends State<Products> {
  Future<List<Customer>> userData;
  void initState(){
    super.initState();
    userData = _getProduct();
  }
  @override
  Widget build(BuildContext context) {
    print("----------");
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Products"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context) ,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Customer>>(
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
                      leading: Text(snapshot.data[index].cid.toString()),
                      title: Text(snapshot.data[index].cname),
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
                  return AddCustomer();
                }
              ),
            ).then((value){
              setState(() {
                userData = _getProduct();
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

Future<List<Customer>> _getProduct() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllCustomer");
  var jsonData = json.decode(data.body);
  List<Customer> cust = [];
  for(var u in jsonData["AllCustomer"]){
    Customer customer = Customer(u["cid"], u["cname"], u["address"], u["contact"], u["gender"]);
    cust.add(customer);
  }
  return cust;
}



// import 'package:http/http.dart' as http;
//
// Map data = {
//   'key1': 1,
//   'key2': "some text"
// }
//
// String body = json.encode(data);
//
// http.Response response = await http.post(
// url: 'https://example.com',
// headers: {"Content-Type": "application/json"},
// body: body,
// );
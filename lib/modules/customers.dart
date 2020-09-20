import 'package:flutter/material.dart';
import 'package:stockist/screens/addCust.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:stockist/classes.dart';
class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  Future<List<Customer>> userData;
  void initState(){
    super.initState();
    userData = _getCustomer();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Customer"),
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
                userData = _getCustomer();
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

Future<List<Customer>> _getCustomer() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllCustomer");
  var jsonData = json.decode(data.body);
  List<Customer> cust = [];
  for(var u in jsonData["AllCustomer"]){
    Customer customer = Customer(u["cid"], u["cname"], u["address"], u["contact"], u["gender"]);
    cust.add(customer);
  }
  return cust;
}
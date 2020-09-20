import 'package:flutter/material.dart';
import 'package:stockist/classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:stockist/screens/addPur.dart';
class Purchases extends StatefulWidget {
  @override
  _PurchasesState createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {
  Future<List<Buy>> userData;
  void initState(){
    super.initState();
    userData = _getBuys();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Buys"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context) ,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Buy>>(
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
                      leading: Text(snapshot.data[index].id.toString()),
                      title: Text(snapshot.data[index].sname),
                      subtitle: Text("Product: ${snapshot.data[index].pname}\nQuantity: ${snapshot.data[index].quantity}\nRate: ${snapshot.data[index].rate}\nDate: ${snapshot.data[index].date}\nAmount: ${snapshot.data[index].amount}"
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
                    return AddPurchase();
                  }
              ),
            ).then((value){
              setState(() {
                userData = _getBuys();
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


Future<List<Buy>> _getBuys() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllPurchase");
  var jsonData = json.decode(data.body);
  List<Buy> cust = [];
  for(var u in jsonData["AllPurchase"]){
    Buy buy = Buy(u["id"], u["sname"], u["pname"], u["quantity"], u["rate"], u["date"], u["amount"]);
    cust.add(buy);
  }
  return cust;
}
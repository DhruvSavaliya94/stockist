import 'package:flutter/material.dart';
import 'package:stockist/classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:stockist/screens/addSell.dart';
class Sells extends StatefulWidget {
  @override
  _SellsState createState() => _SellsState();
}

class _SellsState extends State<Sells> {
  Future<List<Sell>> userData;
  void initState(){
    super.initState();
    userData = _getSells();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Sells"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context) ,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Sell>>(
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
                      title: Text(snapshot.data[index].cname),
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
                    return AddSell();
                  }
              ),
            ).then((value){
              setState(() {
                userData = _getSells();
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


Future<List<Sell>> _getSells() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllSales");
  var jsonData = json.decode(data.body);
  List<Sell> cust = [];
  for(var u in jsonData["AllSales"]){
    Sell sell = Sell(u["id"], u["cname"], u["pname"], u["quantity"], u["rate"], u["date"], u["amount"]);
    cust.add(sell);
  }
  return cust;
}
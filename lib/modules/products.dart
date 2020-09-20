import 'package:flutter/material.dart';
import 'package:stockist/classes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:stockist/screens/addProd.dart';

//Forms:  https://codingwithjoe.com/building-forms-with-flutter/
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Future<List<Product>> userData;
  void initState(){
    super.initState();
    userData = _getProduct();
  }
  @override
  Widget build(BuildContext context) {
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
          child: FutureBuilder<List<Product>>(
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
                      leading: Text(snapshot.data[index].pid.toString()),
                      title: Text(snapshot.data[index].pname),
                      subtitle: Text("Category: ${snapshot.data[index].name}\nQuantity: ${snapshot.data[index].quantity}\nCostprice: ${snapshot.data[index].costprice}\nSellingprice: ${snapshot.data[index].sellingprice}"
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
                    return AddProduct();
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

Future<List<Product>> _getProduct() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllProduct");
  var jsonData = json.decode(data.body);
  List<Product> cust = [];
  for(var u in jsonData["AllProduct"]){
    Product product = Product(u["pid"], u["pname"], u["name"], u["quantity"], u["costprice"], u["sellingprice"]);
    cust.add(product);
  }
  return cust;
}
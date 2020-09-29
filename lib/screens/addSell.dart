import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
class AddSell extends StatefulWidget {
  @override
  _AddSellState createState() => _AddSellState();
}

class _AddSellState extends State<AddSell> {
  var now;
  var formatter;
  String today;
  final _formKey = GlobalKey<FormState>();
  FormSell user = new FormSell();
  List<DropdownMenuItem<String>> _dropDownMenuItemsC;
  List<DropdownMenuItem<String>> _dropDownMenuItemsP;
  String _selectedItemCustomer;
  String _selectedItemProduct;

  Future<void> _getItemC() async {
    http.Response data = await http
        .get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllCustomer");
    var jsonData = json.decode(data.body);
    List<CustomerListItem> cust = [];
    for (var u in jsonData["AllCustomer"]) {
      CustomerListItem customerListItem =
          CustomerListItem(u["cid"], u["cname"]);
      cust.add(customerListItem);
    }
    setState(() {
      _dropDownMenuItemsC = cust
          .map((CustomerListItem value) => DropdownMenuItem(
                value: value.cid.toString(),
                child: Text(value.cname),
              ))
          .toList();
    });
  }

  Future<void> _getItemP() async {
    http.Response data = await http
        .get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllProduct");
    var jsonData = json.decode(data.body);
    List<ProductListItem> cust = [];
    for (var u in jsonData["AllProduct"]) {
      ProductListItem productListItem = ProductListItem(u["pid"], u["pname"]);
      cust.add(productListItem);
    }
    setState(() {
      _dropDownMenuItemsP = cust
          .map((ProductListItem value) => DropdownMenuItem(
                value: value.pid.toString(),
                child: Text(value.pname),
              ))
          .toList();
    });
  }
  String getdate(){
    now = new DateTime.now();
    formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
  Future<bool> _AddSell() async {
    Map<String, dynamic> data = {
      'custid': user.custid,
      'prcpid': user.prcpid,
      'prquantity': user.prquantity,
      'prtrate': user.prtrate,
      'sdate': user.sdate
    };
    String body = json.encode(data);
    print(body);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post(
          "http://10.0.2.2/stockist-backend/api.php?apicall=selling",
          data: formData);
      var jsonData = json.decode(response.data);
      var d = jsonData["error"] == "false" ? true : false;
      String ms = jsonData["message"];
      _showDialog(context, ms);
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    today=getdate();
    _getItemC();
    _getItemP();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("New sales"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            autovalidate: false,
            child: new ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              children: <Widget>[
                Center(
                  child: Text(
                    "Create Sales",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                ),
                ListTile(
                  title: Text('Customer'),
                  trailing: DropdownButton(
                    value: _selectedItemCustomer,
                    hint: Text('Choose'),
                    onChanged: ((String newValue) {
                      setState(() {
                        _selectedItemCustomer = newValue;
                        user.custid = int.parse(newValue);
                      });
                    }),
                    items: _dropDownMenuItemsC,
                  ),
                ),
                ListTile(
                  title: Text('Product'),
                  trailing: DropdownButton(
                    value: _selectedItemProduct,
                    hint: Text('Choose'),
                    onChanged: ((String newValue) {
                      setState(() {
                        _selectedItemProduct = newValue;
                        user.prcpid = int.parse(newValue);
                      });
                    }),
                    items: _dropDownMenuItemsP,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter Quantity',
                      labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value.isEmpty || int.parse(value)<=0) {
                      return 'Please enter valid quantity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.prquantity = int.parse(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter Cost Price',
                      labelText: 'Selling Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value.isEmpty || int.parse(value)<=0) {
                      return 'Please enter valid sellingprice';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.prtrate = int.parse(value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          user.sdate=today;
                        });
                        print("Process data");
                        _formKey.currentState.save();
                        _AddSell();
                      } else {
                        print('Error');
                      }
                    },
                    child: Text('SUBMIT'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerListItem {
  int cid;
  String cname;
  CustomerListItem(this.cid, this.cname);
}

class ProductListItem {
  int pid;
  String pname;
  ProductListItem(this.pid, this.pname);
}

class FormSell {
  int custid;
  int prcpid;
  int prquantity;
  int prtrate;
  String sdate;
}

void _showDialog(BuildContext context, String msg) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert!"),
        content: new Text(msg),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

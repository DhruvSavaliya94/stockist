import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
class AddPurchase extends StatefulWidget {
  @override
  _AddPurchaseState createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  var now;
  var formatter;
  String today;
  final _formKey = GlobalKey<FormState>();
  FormPurch user = new FormPurch();
  List<DropdownMenuItem<String>> _dropDownMenuItemsS;
  List<DropdownMenuItem<String>> _dropDownMenuItemsP;
  String _selectedItemSupplier;
  String _selectedItemProduct;

  Future<void> _getItemS() async {
    http.Response data = await http
        .get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllSupplier");
    var jsonData = json.decode(data.body);
    List<SupplierListItem> cust = [];
    for (var u in jsonData["AllSupplier"]) {
      SupplierListItem supplierListItem =
      SupplierListItem(u["sid"], u["sname"]);
      cust.add(supplierListItem);
    }
    setState(() {
      _dropDownMenuItemsS = cust
          .map((SupplierListItem value) => DropdownMenuItem(
        value: value.sid.toString(),
        child: Text(value.sname),
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
  Future<bool> _AddPurch() async {
    Map<String, dynamic> data = {
      'prcpid': user.prcpid,
      'supid': user.supid,
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
          "http://10.0.2.2/stockist-backend/api.php?apicall=buying",
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
    _getItemS();
    _getItemP();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("New Purchase"),
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
                    "Create Product",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),
                ),
                ListTile(
                  title: Text('Supplier'),
                  trailing: DropdownButton(
                    value: _selectedItemSupplier,
                    hint: Text('Choose'),
                    onChanged: ((String newValue) {
                      setState(() {
                        _selectedItemSupplier = newValue;
                        user.supid = int.parse(newValue);
                      });
                    }),
                    items: _dropDownMenuItemsS,
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
                      labelText: 'Costprise'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value.isEmpty || int.parse(value)<=0) {
                      return 'Please enter valid costprice';
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
                        _AddPurch();
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

class SupplierListItem {
  int sid;
  String sname;
  SupplierListItem(this.sid, this.sname);
}

class ProductListItem {
  int pid;
  String pname;
  ProductListItem(this.pid, this.pname);
}

class FormPurch {
  int prcpid;
  int supid;
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  FormProduct user = new FormProduct();
  List<CategoryListItem> _categoryListItem;
  List<SupplierListItem> _supplierListItem;
  List<DropdownMenuItem<CategoryListItem>> _dropdownMenuItemsCategory;
  List<DropdownMenuItem<SupplierListItem>> _dropdownMenuItemSupplier;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedItemCategory;
  SupplierListItem _selectedItemSupplier;

  Future<List<CategoryListItem>> _getItemC() async {
    http.Response data = await http
        .get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllCategory");
    var jsonData = json.decode(data.body);
    List<CategoryListItem> cust = [];
    for (var u in jsonData["AllCategory"]) {
      CategoryListItem categoryListItem =
          CategoryListItem(u["cpid"], u["name"]);
      cust.add(categoryListItem);
    }
    setState(() {
      _dropDownMenuItems = cust
          .map((CategoryListItem value) => DropdownMenuItem(
                value: value.cpid.toString(),
                child: Text(value.name),
              ))
          .toList();
    });
  }

  Future<bool> _AddProduct() async {
    Map<String, dynamic> data = {
      'prpname': user.prpname,
      'prcpid': user.prcpid,
      'prquantity': user.prquantity,
      'prcostprice': user.prcostprice,
      'prsellingprice': user.prsellingprice
    };
    String body = json.encode(data);
    print(data);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post(
          "http://10.0.2.2/stockist-backend/api.php?apicall=addproducts",
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
    _getItemC();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("New Product"),
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
                )),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Name'),
                  inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.prpname = value;
                  },
                ),
                ListTile(
                  title: Text('DropDownButton with hint:'),
                  trailing: DropdownButton(
                    value: _selectedItemCategory,
                    hint: Text('Choose'),
                    onChanged: ((String newValue) {
                      setState(() {
                        _selectedItemCategory = newValue;
                        user.prcpid=int.parse(newValue);
                      });
                    }),
                    items: _dropDownMenuItems,
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
                    if (value.isEmpty) {
                      return 'Please enter valid phone number';
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
                      labelText: 'Phone'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.prcostprice = int.parse(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter Selling Price',
                      labelText: 'Phone'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.prsellingprice = int.parse(value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("Process data");
                        _formKey.currentState.save();
                        _AddProduct();
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

class CategoryListItem {
  int cpid;
  String name;
  CategoryListItem(this.cpid, this.name);
  // factory CategoryListItem.fromJson(Map<String, dynamic> json) {
  //   return CategoryListItem(json['cpid'],json['name']);
  // }
}

class SupplierListItem {
  int sid;
  String name;
  SupplierListItem(this.sid, this.name);
}

class FormProduct {
  String prpname;
  int prcpid;
  int prquantity;
  int prcostprice;
  int prsellingprice;
}

// List<DropdownMenuItem<CategoryListItem>> buildDropDownMenuItems(List<CategoryListItem> listItems){
//   List<DropdownMenuItem<CategoryListItem>> items = List();
//   for (CategoryListItem listItem in listItems) {
//     items.add(
//       DropdownMenuItem(
//         child: Text(listItem.name),
//         value: listItem,
//       ),
//     );
//   }
//   return items;
// }

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

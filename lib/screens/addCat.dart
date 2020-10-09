import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();
  FormCategory user = new FormCategory();
  Future<bool> _addCategory() async {
    Map<String,dynamic> data = {
      'ctname': user.name,
      'ctdes': user.desc,
    };
    String body = json.encode(data);
    print(body);
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(data);
      var response = await dio.post("http://10.0.2.2/stockist-backend/api.php?apicall=addcategory", data: formData);
      var jsonData = json.decode(response.data);
      var d = jsonData["error"]=="false" ? true : false;
      String ms = jsonData["message"];
      _showDialog(context,ms);
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("New Category"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);},
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
                      "Create Category",
                      style: TextStyle(fontSize: 25, color: Colors.black54),
                    )),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter category name',
                      labelText: 'Name'),
                  inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter des',
                      labelText: 'Description'),
                  inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.desc = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("Process data");
                        _formKey.currentState.save();
                        _addCategory();
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

class FormCategory {
  String name;
  String desc;
}
void _showDialog(BuildContext context,String msg) {
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
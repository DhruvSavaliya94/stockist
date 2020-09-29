import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

import '../classes.dart';

enum Gender { Male, Female }

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  FormCustomer user = new FormCustomer();
  Gender _gender = Gender.Male;
  Future<bool> _AddCustomer() async {
    Map<String,dynamic> data = {
      'custname': user.cname,
      'caddress': user.address,
      'ccont' : user.contact,
      'gender': user.gender
    };
    String body = json.encode(data);
      print(body);
      var dio = Dio();
      try {
        FormData formData = new FormData.fromMap(data);
        var response = await dio.post("http://10.0.2.2/stockist-backend/api.php?apicall=addcustomer", data: formData);
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
          title: Text("New Customer"),
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
                  "Create Customer",
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
                    user.cname = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.edit_location),
                      hintText: 'Enter your address',
                      labelText: 'Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.address = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter your phone number',
                      labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    new WhitelistingTextInputFormatter(new RegExp(r'^[0-9]*$')),
                    new LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (value) {
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    user.contact = value;
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.insert_emoticon),
                  Radio(
                        value: Gender.Male,
                        groupValue: _gender,
                        onChanged: (Gender value) {
                          setState(() {
                            _gender = value;
                            value==Gender.Male ? user.gender=1 : user.gender=0;
                          });
                        },
                      ),Text('Male'),
                    Radio(
                      value: Gender.Female,
                      groupValue: _gender,
                      onChanged: (Gender value) {
                        setState(() {
                          _gender = value;
                          value==Gender.Male ? user.gender=1 : user.gender=0;
                        });
                      },
                    ),Text('Female'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("Process data");
                        _formKey.currentState.save();
                        _AddCustomer();
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

class FormCustomer {
  String cname;
  String address;
  String contact;
  int gender=1;
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
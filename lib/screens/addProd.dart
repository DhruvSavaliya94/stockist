import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<CategoryListItem> _categoryListItem;
  List<SupplierListItem> _supplierListItem;
  List<DropdownMenuItem<CategoryListItem>> _dropdownMenuItemsCategory;
  List<DropdownMenuItem<SupplierListItem>> _dropdownMenuItemSupplier;
  CategoryListItem _selectedItemCategory;
  SupplierListItem _selectedItemSupplier;
  Future<void> _getItemC() async {
    http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getAllCategory");
    var jsonData = json.decode(data.body);
    List<CategoryListItem> cust = [];
    for(var u in jsonData["AllCategory"]){
      CategoryListItem categoryListItem = CategoryListItem(u["cpid"], u["name"]);
      cust.add(categoryListItem);
    }
    _categoryListItem=cust;
  }

  @override
  void initState() {
    super.initState();
    _getItemC();
    _dropdownMenuItemsCategory = buildDropDownMenuItems(_categoryListItem);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Button"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: DropdownButton<CategoryListItem>(
            value: _selectedItemCategory,
            items: _dropdownMenuItemsCategory,
            onChanged: (value) {
              setState(() {
                _selectedItemCategory = value;
              });
            }),
      ),
    );
  }
}

class CategoryListItem {
  int cpid;
  String name;
  CategoryListItem(this.cpid, this.name);
}
class SupplierListItem{
  int sid;
  String name;
  SupplierListItem(this.sid,this.name);
}


List<DropdownMenuItem<CategoryListItem>> buildDropDownMenuItems(List<CategoryListItem> listItems){
  List<DropdownMenuItem<CategoryListItem>> items = List();
  for (CategoryListItem listItem in listItems) {
    items.add(
      DropdownMenuItem(
        child: Text(listItem.name),
        value: listItem,
      ),
    );
  }
  return items;
}
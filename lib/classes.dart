

import 'package:flutter/cupertino.dart';

class Supplier{
  final int sid;
  final String sname;
  final String address;
  final String contact;
  final int gender;

  Supplier(this.sid, this.sname, this.address, this.contact, this.gender);
}

class Customer{
  final int cid;
  final String cname;
  final String address;
  final String contact;
  final int gender;

  Customer(this.cid, this.cname, this.address, this.contact, this.gender);
}

class Category{
  final int cpid;
  final String name;
  final String desc;

  Category(this.cpid,this.name,this.desc);
}

class Product{
  final int pid;
  final String pname;
  final String name;
  final int quantity;
  final int costprice;
  final int sellingprice;

  Product(this.pid,this.pname,this.name,this.quantity,this.costprice,this.sellingprice);
}

class Sell{
  final int id;
  final String cname;
  final String pname;
  final int quantity;
  final int rate;
  final String date;
  final int amount;

  Sell(this.id,this.cname,this.pname,this.quantity,this.rate,this.date,this.amount);
}

class Buy{
  final int id;
  final String sname;
  final String pname;
  final int quantity;
  final int rate;
  final String date;
  final int amount;

  Buy(this.id,this.sname,this.pname,this.quantity,this.rate,this.date,this.amount);
}
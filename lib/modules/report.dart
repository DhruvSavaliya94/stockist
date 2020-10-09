import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Future<List<ProfitReport>> userData;
  void initState(){
    super.initState();
    userData = _getReport();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Report"),
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          child: FutureBuilder<List<ProfitReport>>(
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
                      subtitle: Text("Profit ₹: ${snapshot.data[index].profit}"
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
Future<List<ProfitReport>> _getReport() async {
  http.Response data = await http.get("http://10.0.2.2/stockist-backend/api.php?apicall=getReport");
  var jsonData = json.decode(data.body);
  List<ProfitReport> cust = [];
  for(var u in jsonData["Report"]){
    ProfitReport profitReport = ProfitReport(u["pid"], u["pname"], u["profit"]);
    cust.add(profitReport);
  }
  return cust;
}

class ProfitReport{
  final int pid;
  final String pname;
  final String profit;

  ProfitReport(this.pid, this.pname, this.profit);
}
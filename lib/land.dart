import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stockist/modules/categories.dart';
import 'package:stockist/modules/customers.dart';
import 'package:stockist/modules/prediction.dart';
import 'package:stockist/modules/suppliers.dart';
import 'package:stockist/modules/products.dart';
import 'package:stockist/reusablecard.dart';
import 'package:stockist/iconcontent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'modules/customers.dart';
import 'modules/purchase.dart';
import 'modules/report.dart';
import 'modules/sells.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Stockist"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Products();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.productHunt,
                        label: 'Products',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Categories();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: CupertinoIcons.tag,
                        label: 'Products Category',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Customers();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.user,
                        label: 'Customer',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Suppliers();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.teamspeak,
                        label: 'Supplier',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Sells();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.arrowCircleUp,
                        label: 'Sell',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Purchases();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.arrowCircleDown,
                        label: 'Buy',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReportScreen();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.digitalTachograph,
                        label: 'Reports',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PredictionScreen();
                            },
                          ),
                        );
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.grinAlt,
                        label: 'Prediction',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

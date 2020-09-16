import 'package:flutter/material.dart';
import 'package:stockist/products.dart';
import 'package:stockist/reusablecard.dart';
import 'package:stockist/iconcontent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}


class _LandingPageState extends State<LandingPage>{
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
                            builder: (context){
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
                      onPress: () {},
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
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
                        print("tap");
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
                      onPress: () {},
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
                        print("tap");
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.amazon,
                        label: 'Sell',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {},
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.accusoft,
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
                        print("tap");
                      },
                      colour: Colors.deepOrange,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.digitalTachograph,
                        label: 'Reports',
                      ),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.amberAccent,
                      child: Text("Tap me"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                              return Products();
                            },
                          ),
                        );
                      },
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
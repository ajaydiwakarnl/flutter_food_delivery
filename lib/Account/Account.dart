import 'package:flutter/material.dart';
import 'package:food_delivery/String/Strings.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          Strings.sign_up,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
          iconSize: 15,

          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Ajay Diwakar",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                      textAlign: TextAlign.left,),
                  )
                ],
              ),
            ),
            Container(

            ),
            Container(

            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/Login/LoginModel.dart';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:food_delivery/String/Strings.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() =>_AccountState();
}

class _AccountState extends State<Account> {
  UserDetails userDetails = new UserDetails();
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 5,
        title: Text(
          Strings.bottom_account,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),

      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              userDetails.userName !=null ? userDetails.userName : "dd",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                              textAlign: TextAlign.left,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              "89494102211",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                              textAlign: TextAlign.left,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              "kabirdiwakar@gmail.com",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                              textAlign: TextAlign.left,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text(Strings.edit, style: TextStyle(fontSize: 13)),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        disabledColor: Colors.grey,
                        color: Colors.deepOrange,
                        textColor: Colors.white,
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Divider(
                  color: Colors.grey
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            Strings.managed_address,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                            textAlign: TextAlign.left,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            "23,Text 1234 chennai",
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                            textAlign: TextAlign.left,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.black54,
                      iconSize: 15,
                    ),

                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Divider(
                  color: Colors.grey
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            Strings.help,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                            textAlign: TextAlign.left,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Text(
                            Strings.faq_link,
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                            textAlign: TextAlign.left,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.black54,
                      iconSize: 15,
                    ),

                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Divider(
                  color: Colors.grey
              ),
            ),


            Container(
              child: Container(
                  margin: EdgeInsets.only(top:50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45.0,
                    child: RaisedButton(
                      child: Text(Strings.logout, style: TextStyle(fontSize: 15)),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      disabledColor: Colors.grey,
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {

                      },
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

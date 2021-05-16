import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/Account/GetProfile/AccountModel.dart';
import 'package:food_delivery/Account/GetProfile/AccountService.dart';
import 'package:food_delivery/Login/LoginModel.dart';
import 'package:food_delivery/Repository/StoreApiResponse.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() =>_AccountState();
}

class _AccountState extends State<Account> {
  String userName,userEmail,userPhoneNumber,userAddress;
  UsersDetails _userDetails;
  void initState(){
    super.initState();

    setState(() {
      this.getUser();
    });

  }

  getUser() async {
    AccountService accountService = AccountService();
    var response = await accountService.getProfile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(response.usersDetails != null){
        _userDetails = response.usersDetails;
      }
      userAddress =  prefs.get("userAddress");
      userName =  prefs.getString("userName");
      userEmail =  prefs.getString("userEmail");
      userPhoneNumber =  prefs.get("userMobile");


    });

   /*
    setState(() {
      userName =  prefs.getString("userName");
      userEmail =  prefs.getString("userEmail");
      userPhoneNumber =  prefs.get("userMobile");


      log(userName);
      log(userEmail);
      log(userPhoneNumber);
      log(userAddress);

    });*/

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: SingleChildScrollView(
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
                              _userDetails != null ? _userDetails.userName : "joe",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                              textAlign: TextAlign.left,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              _userDetails!= null ? _userDetails.mobileNumber : "12345678",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                              textAlign: TextAlign.left,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              _userDetails  != null ? _userDetails.email  : "joe@gmail.com",
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => editProfile(context),
                          );

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
                    Flexible(
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
                              userAddress != null ? userAddress : "Addresses",
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
                    margin: EdgeInsets.only(top:30),
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
        )

      ),
    );
  }

  Widget editProfile(BuildContext context){
    return new AlertDialog(
      title: Text(
        Strings.edit_account,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child:Container(
                  child:Column(
                    children: [
                      Container(
                        child: new TextFormField(
                          cursorColor: Colors.green,
                          // onSaved: (String val) => setState( () => _userName = val),
                          decoration:  InputDecoration(
                            labelText: Strings.name,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange)
                            ),
                          ),
                          controller: TextEditingController()..text = _userDetails != null ?  _userDetails.userName : userName,

                        ),
                      ),
                      Container(
                        child: new TextFormField(
                          cursorColor: Colors.green,
                          // onSaved: (String val) => setState( () => _email = val),
                          decoration:  InputDecoration(
                            labelText: Strings.email_address,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepOrange)
                            ),
                          ),
                          controller: TextEditingController()..text = _userDetails != null ?  _userDetails.email : userEmail,

                        ),
                      ),
                    ],
                  )

              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                Strings.cancel,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.deepOrange,letterSpacing: 1),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                Strings.save,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.deepOrange,letterSpacing: 1),
              ),
            )
          ],
        )
      ]

    );
  }
}

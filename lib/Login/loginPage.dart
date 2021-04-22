import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/String/Strings.dart';
import 'loginModel.dart';
import 'package:flutter_udid/flutter_udid.dart';



class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        margin: const EdgeInsets.only(top: 300.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 280.0),
              child: Text(Strings.login_account_title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(right: 50.0,top:5.0 ),
              child: Text(Strings.Login_login_create_account_quickly,
                  style: TextStyle(fontSize: 16,color: Colors.white)
              ),
            ),
            Container(
                  width: 400.0,
                  height: 85.0,
                  padding: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    child: Text(Strings.Login_title, style: TextStyle(fontSize: 15)),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                    disabledColor: Colors.grey,
                    color: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                        showLoginPopup(context);
                    },
                  ),
            )
          ],
        ),
      ),
    );
  }
}

void showLoginPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        child: showLoginForm(),
        height: MediaQuery.of(context).size.height  * 1100.0,
      );
    }
  );
}

class showLoginForm extends StatefulWidget {
  @override
  _showLoginFormState createState() => _showLoginFormState();
}

class _showLoginFormState extends State<showLoginForm> {
 final _formKey = GlobalKey<FormState>();
 String _mobileNumber = "";
 String _password = "";
 String _udid = 'Unknown';
 @override
 void initState() {
   super.initState();
   initPlatformState();
 }

 Future<void> initPlatformState() async {
   String udid;
   try {
     udid = await FlutterUdid.udid;
   } on PlatformException {
     udid = 'Failed to get UDID.';
   }
   if (!mounted) return;
   setState(() {
     _udid = udid;
   });
 }

 @override
  Widget build(BuildContext buildContext) {
     return Form(
       key: _formKey,
          child: SingleChildScrollView(child: Column(
              children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top:25.0,right: 340.0),
                    child: Text(Strings.Login_title,
                        style: TextStyle(fontSize: 18,color: Colors.black)
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top:10.0,right: 165.0),
                    child: Text(Strings.enter_your_phone_number,
                        style: TextStyle(fontSize: 15,color: Colors.grey)
                    ),
                  ),
                  Container(
                    margin:const EdgeInsets.only(left:15.0,right: 15.0),
                    child: new TextFormField(
                      cursorColor: Colors.green,
                      onSaved: (String val) => setState( () => _mobileNumber = val),
                      decoration:  InputDecoration(
                        labelText: Strings.phone_number,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        )
                      ),
                      validator:(value){
                        if(value.isEmpty){
                          return "This field is required";
                        }
                        if(value.length < 5){
                          return "Invalid phone number";
                        }
                        if(value.length > 10){
                          return "Invalid phone number";
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  Container(
                    margin:const EdgeInsets.only(left:15.0,right: 15.0,top:10.0 ),
                    child: new TextFormField(
                      cursorColor: Colors.green,
                      onSaved: (String val) => setState( () => _password = val),
                      decoration:  InputDecoration(
                        labelText: Strings.login_password,
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      validator:(value){
                        if(value.isEmpty){
                          return "This field is required";
                        }
                        if(value.length < 6){
                          return "Invalid password";
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 450.0,
                    height: 85.0,
                    padding: EdgeInsets.all(20.0),
                    child: RaisedButton(
                      child: Text(Strings.Login_title, style: TextStyle(fontSize: 15)),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      disabledColor: Colors.grey,
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        _formKey.currentState.save();
                        _formKey.currentState.validate() ?
                          SnackBar(content: Text("This field id required")) :
                          SnackBar(content: Text("This field id required"));
                          callLoginApi(_mobileNumber,_password);
                      },
                    ),
                  ),
                  Text(_udid)
                ] ,

          ),
          ),
      );
  }
}

callLoginApi(mobileNumber,password){
  LoginRequest loginRequest = new LoginRequest();
  loginRequest.mobileNumber = mobileNumber;
  loginRequest.countryCode = "+91";
  loginRequest.password = password;
  //loginRequest.udId =

}

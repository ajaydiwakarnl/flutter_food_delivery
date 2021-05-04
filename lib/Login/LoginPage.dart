import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/CircularLoader.dart';
import 'package:food_delivery/Home/HomePage.dart';
import 'package:food_delivery/String/Strings.dart';
import 'LoginModel.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'LoginService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width : MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top:300.0),
        padding: EdgeInsets.all(20.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //margin: const EdgeInsets.only(right: 280.0),
              child: Text(
                  Strings.login_account_title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                  textAlign: TextAlign.left,),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(Strings.Login_login_create_account_quickly,
                  style: TextStyle(fontSize: 16,color: Colors.white)
              ),
            ),
            Container(
                  width: 500.0,
                  height: 45.0,
                  margin: EdgeInsets.only(top: 20.0),
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
 String _mobileNumber;
 String _password;
 String _udid = 'Unknown';
 bool _isLoading = false;

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
    return CircularLoader(
        child: LoginUi(buildContext), inAsyncall: _isLoading,opacity: 0.5,color: Colors.black);
 }

  Widget LoginUi(BuildContext buildContext) {
     return Form(
       key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Container(
                    child: Text(Strings.Login_title,
                        style: TextStyle(fontSize: 18,color: Colors.black)
                    ),
                  ),
                  Container(
                    child: Text(Strings.enter_your_phone_number,
                        style: TextStyle(fontSize: 15,color: Colors.grey)
                    ),
                  ),
                  Container(
                    child: new TextFormField(
                      cursorColor: Colors.green,
                      onSaved: (String val) => setState( () => _mobileNumber = val),
                      decoration:  InputDecoration(
                        labelText: Strings.phone_number,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,),
                        enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.orange)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)
                        ),
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
                    child:  new TextFormField(
                      cursorColor: Colors.green,
                      onSaved: (String val) => setState( () => _password = val),
                      decoration:  InputDecoration(
                        labelText: Strings.login_password,
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange)
                          ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)
                        ),
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
                    width: 500.0,
                    height: 45.0,
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      child: Text(Strings.Login_title, style: TextStyle(fontSize: 15)),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      disabledColor: Colors.grey,
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {
                        _formKey.currentState.save();
                        _formKey.currentState.validate() ?
                          SnackBar(content: Text("This field id required")) :
                          SnackBar(content: Text("This field id required"));
                          if(_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            LoginRequest loginRequest = new LoginRequest();
                            LoginService loginService = new LoginService();

                            loginRequest.mobileNumber = _mobileNumber;
                            loginRequest.countryCode = "+91";
                            loginRequest.password = _password;
                            loginRequest.udId = _udid;
                            var response = await loginService.login(loginRequest);

                            if(response.error == "false"){
                              setState(() {_isLoading = false;});
                              Fluttertoast.showToast( msg: response.errorMessage, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIos: 2, backgroundColor: Colors.black, textColor: Colors.white);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
                            }else{
                              setState(() {_isLoading = false;});
                              Fluttertoast.showToast( msg: response.errorMessage, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIos: 2, backgroundColor: Colors.black, textColor: Colors.white);
                            }
                          }
                      },
                    ),
                  ),

                ] ,

          ),
          ),
      );
  }
}

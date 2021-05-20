import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/CheckUserExist/CheckUserExistModel.dart';
import 'package:food_delivery/CheckUserExist/CheckUserExistService.dart';
import 'package:food_delivery/CircularLoader.dart';
import 'package:food_delivery/Home/HomePage.dart';
import 'package:food_delivery/OtpVerfication/OtpVerification.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginModel.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'LoginService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width : MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(top:300.0),
                child: Text(
                  Strings.login_account_title,
                  style: TextStyle(fontSize: 20, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(Strings.Login_login_create_account_quickly,
                    style: TextStyle(fontSize: 15,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black)
                ),
              ),
              Container(
                width: 500.0,
                height: 46.0,
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  child: Text(Strings.Login_title, style: TextStyle(fontFamily:'Proxima_Nova_ScOsf_Bold',fontSize: 18)),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0)),
                  disabledColor: Colors.grey,
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  onPressed: () {
                    showLoginPopup(context);
                  },
                ),
              )
            ],
          ),
        )


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
        height: MediaQuery.of(context).size.height,
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
 bool _showPasswordInput = false;

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

   final SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('udid', udid);
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
                        style: TextStyle(fontSize: 20, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500)
                    ),
                  ),
                  Container(
                    child: Text(Strings.enter_your_phone_number,
                        style: TextStyle(fontSize: 14,
                            fontFamily:'Proxima_Nova_Alt_Light',
                            color: Colors.black)
                    ),
                  ),
                  Container(
                    child: new TextFormField(
                      cursorColor: Colors.deepOrange,
                      onSaved: (String val) => setState( () => _mobileNumber = val),
                      decoration:  InputDecoration(
                        labelText: Strings.phone_number,
                        labelStyle: TextStyle(fontSize: 14,
                            fontFamily:'Proxima_Nova_Alt_Light',
                            color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.deepOrange,width: 2 ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ), //Email
                  ),
                  _showPasswordInput ? Container(
                    child:  new TextFormField(
                      cursorColor: Colors.deepOrange,
                      obscureText: true,
                      onSaved: (String val) => setState( () => _password = val),
                      decoration:  InputDecoration(
                        labelText: Strings.login_password,
                        labelStyle: TextStyle(fontSize: 14,
                            fontFamily:'Proxima_Nova_Alt_Light',
                            color: Colors.black
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                          ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                        ),
                      ),
                    ), //Password
                  ) : SizedBox(),
                  Container(
                    width: 500.0,
                    height: 46.0,
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      child: Text(Strings.Login_title, style: TextStyle(fontSize: 18, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.white,fontWeight: FontWeight.w500)),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      disabledColor: Colors.grey,
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      onPressed: () async {
                        _formKey.currentState.save();

                          if(_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            CheckUserExistRequest _ischeckUserExistRequest = new CheckUserExistRequest();
                            CheckUserExistService _ischeckUserExistService = new CheckUserExistService();

                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('mobileNumber', _mobileNumber);

                            _ischeckUserExistRequest.mobileNumber = _mobileNumber != null ? _mobileNumber : "";
                            _ischeckUserExistRequest.countryCode = "+91";

                            var response = await _ischeckUserExistService.CheckUser(_ischeckUserExistRequest);
                            log(response.errorMessage);

                            if(response.error == "true"){
                              Fluttertoast.showToast(
                                  msg: response.errorMessage,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM, timeInSecForIos: 2,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 13

                              );
                            }
                            else if(response.isNewUser == "true"){
                              setState(() {
                                _isLoading = false;
                              });

                              Navigator.push(context, MaterialPageRoute(builder: (
                                  context) => OtpVerification()),);


                            }else{
                              setState(() {
                                _showPasswordInput = true;
                                _isLoading = false;
                              });

                              if( _showPasswordInput == true){

                                LoginRequest loginRequest = new LoginRequest();
                                LoginService loginService = new LoginService();

                                if( _password != null ){

                                  loginRequest.mobileNumber = _mobileNumber;
                                  loginRequest.countryCode = "+91";
                                  loginRequest.password = _password != null ? _password : "";
                                  loginRequest.udId = _udid != null ? _udid : "";

                                  var response = await loginService.login(loginRequest);
                                   log(response.errorMessage);
                                  if(response.error == "false"){
                                    setState(() {_isLoading = false;});
                                    Fluttertoast.showToast(
                                        msg: Strings.login_sucess,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM, timeInSecForIos: 2,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 13

                                    );

                                    Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);
                                  }else{
                                    setState(() {_isLoading = false;});
                                    Fluttertoast.showToast(
                                        msg: response.errorMessage,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM, timeInSecForIos: 2,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 13

                                    );

                                  }
                                }
                              }
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

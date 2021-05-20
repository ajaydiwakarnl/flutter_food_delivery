import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/Login/LoginPage.dart';
import 'package:food_delivery/Register/RegisterModel.dart';
import 'package:food_delivery/Register/RegisterService.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _userPhoneNumber,_otp_number,_userName,_countryCode,_email,_password,_udId;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  void initState(){
    super.initState();

    setState(() {
       this.getUserMobileNumber();
       this.getUdid();
       this.getOtpNumber();
    });

  }

  getUserMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userPhoneNumber =  prefs.get("mobileNumber");
    log(_userPhoneNumber);
  }

  getUdid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _udId =  prefs.get("udid");
    log(_udId);
  }

  getOtpNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _otp_number =  prefs.get("otpNumber");
    log(_otp_number);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          Strings.sign_up,
          style: TextStyle(fontSize: 15,
              fontFamily:'Proxima_Nova_Bold',
              color: Colors.black),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
          iconSize: 15,

          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top:30.0,left:20,right: 20,bottom: 20),
        child: Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(Strings.phone_number,
                    style: TextStyle(fontSize: 14,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black)
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:6.0),
                child: Text(_userPhoneNumber != null ? "+91 " + _userPhoneNumber : "",
                    style: TextStyle(fontSize: 14,
                        fontFamily:'Proxima_Nova_Bold',
                        color: Colors.black)
                ),
              ),//
              Container(
                child: new TextFormField(
                  cursorColor: Colors.deepOrange,
                  onSaved: (String val) => setState( () => _email = val),
                  decoration:  InputDecoration(
                    labelText: Strings.email_address,
                    labelStyle: TextStyle(fontSize: 14,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                    ),
                  ),

                ),
              ),
              Container(
                child: new TextFormField(
                  cursorColor: Colors.deepOrange,
                   onSaved: (String val) => setState( () => _userName = val),
                  decoration:  InputDecoration(
                    labelText: Strings.name,
                    labelStyle: TextStyle(fontSize: 14,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange)
                    ),
                  ),

                ),
              ),
              Container(
                child: new TextFormField(
                  cursorColor: Colors.deepOrange,
                  obscureText: true,
                  onSaved: (String val) => setState( () => _password = val),
                  decoration:  InputDecoration(
                    labelText: Strings.login_password,
                    labelStyle: TextStyle(fontSize: 14,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange,width: 2)
                    ),
                  ),
                ), //Email
              ),
              Container(
                margin: EdgeInsets.only(top:20.0),
                child: Text(
                  Strings.terms_and_condtion,
                  style: TextStyle(fontSize: 14,
                      fontFamily:'Proxima_Nova_Alt_Light',
                      color: Colors.black)
                )
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top:30),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 46.0,
                      child: RaisedButton(
                        child: Text(Strings.sign_up, style: TextStyle(fontSize: 16,
                            fontFamily:'Proxima_Nova_Bold',
                            color: Colors.white)),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        disabledColor: Colors.grey,
                        color: Colors.deepOrange,
                        textColor: Colors.white,
                        onPressed: () async {
                          _formKey.currentState.save();
                            setState(() {
                              _isLoading = true;
                            });
                            _countryCode = "+91";

                            RegisterRequest registerRequest = new RegisterRequest();
                            RegisterService registerService = new RegisterService();

                            registerRequest.otpNumber = _otp_number ?? "";
                            registerRequest.udId = _udId ?? "";
                            registerRequest.countryCode = _countryCode ?? "";
                            registerRequest.mobileNumber = _userPhoneNumber ?? "";
                            registerRequest.password = _password ?? "";
                            registerRequest.email = _email ?? "";
                            registerRequest.userName = _userName ?? "";

                            var response =  await registerService.CheckUser(registerRequest);
                            if(response.error == "false"){
                              setState(() {_isLoading = false;});
                              Fluttertoast.showToast(
                                  msg: response.errorMessage,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM, timeInSecForIos: 2,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 13);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),);
                            }else{
                              setState(() {_isLoading = false;});
                              Fluttertoast.showToast(
                                  msg: response.errorMessage,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM, timeInSecForIos: 2,
                                  backgroundColor: Colors.black, textColor: Colors.white,fontSize: 13);

                            }

                          },
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

makeUserSignup(_userPhoneNumber,_email,_userName,_password,_otp_number,_countryCode,_udId) async {

  RegisterRequest registerRequest = new RegisterRequest();
  RegisterService registerService = new RegisterService();

  registerRequest.otpNumber = _otp_number ?? "";
  registerRequest.udId = _udId ?? "";
  registerRequest.countryCode = _countryCode ?? "";
  registerRequest.mobileNumber = _userPhoneNumber ?? "";
  registerRequest.password = _password ?? "";
  registerRequest.email = _email ?? "";
  registerRequest.userName = _userName ?? "";

  var response =  await registerService.CheckUser(registerRequest);

  log(response.errorMessage);
  return response.error;
}
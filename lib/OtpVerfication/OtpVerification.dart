import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/OtpVerfication/OtpModel.dart';
import 'package:food_delivery/OtpVerfication/OtpService.dart';
import 'package:food_delivery/Register/RegisterPage.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerification extends StatefulWidget {
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  Timer _timer;
  int _startCount = 10;
  String _moblieNumber,_countryCode,_otpNumber,_udId;
  String _digit_1,_digit_2,_digit_3,_digit_4,_digit_5,_digit_6;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void initState(){
    super.initState();
    this.startTimer();
  }
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
        if (_startCount == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _startCount--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
          iconSize: 15,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child:  Center(
                child: Text(
                  Strings.awesome_thanks,
                  style: TextStyle(
                      fontSize: 20, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8,right: 8),
              child:  Center(
                child: Text(
                  Strings.confirmation_code_otp,
                  style: TextStyle(fontSize: 15,
                      fontFamily:'Proxima_Nova_Alt_Light',
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8,right: 8),
              child:  Center(
                child: Text(
                  Strings.get_it_soon,
                  style: TextStyle(fontSize: 15,
                      fontFamily:'Proxima_Nova_Alt_Light',
                      color: Colors.black),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(30),
                child: PinEntryTextField(
                  showFieldAsBox: false,
                  fields: 6,
                  onSubmit: (String pin){
                    setState(() {
                      _otpNumber = pin;
                    });

                  },
                ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                 // RECALL THE API
                },
                child:  Center(
                  child:
                  _startCount!=0 ?
                  Text(Strings.resend_within +" "+"$_startCount"+" "+ Strings.second, style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.deepOrange,fontWeight: FontWeight.w500),) :
                  Text(Strings.resend, style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.deepOrange,fontWeight: FontWeight.w500),),
                ),
              )

            ),
            Container(
              child: Container(
                  margin: EdgeInsets.only(top:30,left: 30,right: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 46.0,
                    child: RaisedButton(
                      child: Text(Strings.verify_and_proceed, style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.white,fontWeight: FontWeight.w500)),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      disabledColor: Colors.grey,
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      onPressed: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        _formKey.currentState.save();
                        //_otpNumber = _digit_1 + _digit_2 + _digit_3 + _digit_4 + _digit_5 + _digit_6;

                         prefs.setString("otpNumber", _otpNumber);
                        _countryCode = "+91";
                        _udId = prefs.getString('udid');
                        _moblieNumber = prefs.get('mobileNumber');

                        setState(() {
                          _isLoading = true;
                        });
                        var response = await makeUserOTPLogin(_moblieNumber,_countryCode,_otpNumber,_udId);
                        //var response  = "false";
                        if(response == "false"){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterPage()),);
                        }else{
                          Fluttertoast.showToast( msg: "Invalid otp.please try again", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIos: 2, backgroundColor: Colors.black, textColor: Colors.white);
                        }
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

makeUserOTPLogin(_moblieNumber,_countryCode,_otpNumber,_udId) async {
  OtpLoginRequest otpLoginRequest = new OtpLoginRequest();
 OtpService otpService = new OtpService();
 otpLoginRequest.mobileNumber = _moblieNumber;
 otpLoginRequest.countryCode = _countryCode;
 otpLoginRequest.udId = _udId;
 otpLoginRequest.otpNumber = _otpNumber;
 var response = await otpService.otpLogin(otpLoginRequest);
 log(response.error);
 return response.error;
}


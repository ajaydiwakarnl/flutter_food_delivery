import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/String/Strings.dart';
import 'loginModel.dart';
import 'package:form_validator/form_validator.dart';



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
  LoginRequest loginRequest = new LoginRequest();
  var formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
          height: MediaQuery.of(context).size.height  * 1100.0,
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
                    margin: const EdgeInsets.only(top:10.0,right: 280.0),
                    child: Text(Strings.phone_number,
                        style: TextStyle(fontSize: 14,color: Colors.grey)
                    ),
                  ),
                  Container(
                    margin:const EdgeInsets.only(left:15.0,right: 15.0),
                    child: new TextFormField(
                      cursorColor: Colors.green,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: ValidationBuilder().phone("This field  is required").minLength(10).maxLength(10).build(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                        doLogin(formKey);
                      },
                    ),
                  )
                ] ,
            ),
          ),
      );
    }
  );
}
doLogin(formKey){
  final isValid = formKey.currentState.validate();
  if (!isValid) {
    return;
  }
  formKey.currentState.save();
}
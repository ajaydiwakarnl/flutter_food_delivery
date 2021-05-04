import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_delivery/Login/LoginPage.dart';

import 'Home/HomePage.dart';
import 'Login/LoginService.dart';

void main(){
  runApp(splashApp());
}

class splashApp  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: splashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class splashPage extends StatefulWidget {
  @override
  _splashPageState createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  void initState(){
    super.initState();
    Timer(
        Duration(seconds: 4),
            () =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()))
    );

    /*Timer(
        Duration(seconds: 4),
            () =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()))
    );*/
    /*if( checkUserIsLoggedIn() != null ){
      Timer(
          Duration(seconds: 4),
              () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage() ))
      );
    }else {
      Timer(
          Duration(seconds: 4),
              () =>
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()))
      );
    }*/
  }
    @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Image.asset("assets/images/logo.png")
    );
  }
}

checkUserIsLoggedIn() async {
  String token = await LoginService().getToken();
  return token;

}

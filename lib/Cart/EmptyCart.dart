import 'package:flutter/material.dart';

class EmptyCart extends StatefulWidget {
  @override
  _EmptyCartState createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
          iconSize: 15,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
            child:Image.asset("assets/images/empty_cart.jpg")
        ),
      ),
    );
  }
}

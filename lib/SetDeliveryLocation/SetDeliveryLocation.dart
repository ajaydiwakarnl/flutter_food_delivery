import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/SetDeliveryLocation/AddAddress.dart';
import 'package:food_delivery/SetDeliveryLocation/GetAddressModel.dart';
import 'package:food_delivery/SetDeliveryLocation/GetAddressService.dart';
import 'package:food_delivery/String/Strings.dart';

class SetDeliveryLocation extends StatefulWidget {
  @override
  _SetDeliveryLocationState createState() => _SetDeliveryLocationState();
}

class _SetDeliveryLocationState extends State<SetDeliveryLocation> {
  List<Address> _listOfAddress;
  void initState(){
    super.initState();
    this.callAddressList();
  }
  callAddressList() async {
    GetAddress getAddress = new GetAddress();
    GetAddressService getAddressService = new GetAddressService();
    var response = await getAddressService.GetAddressList();
    if(response.address.isNotEmpty){
      _listOfAddress = response.address;
    }else{
      _listOfAddress = [];
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child:Text(
                Strings.set_delivery_bottom,
                style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),
                )
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top:20.0,left: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          new GestureDetector(
            /*onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAddress()),
              );
            },*/
            child:Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child:Text(
                          Strings.current_location,
                          style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal),
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child:Text(
                          Strings.using_gps,
                          style: TextStyle(fontSize: 16,color: Colors.black38,fontWeight: FontWeight.normal),
                        )
                    ),
                    Divider(
                        color: Colors.black
                    )
                  ]
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:20.0,left: 10.0,bottom: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child:Text(
                        Strings.saved_address,
                        style: TextStyle(fontSize: 14,color: Colors.black38,fontWeight: FontWeight.normal,letterSpacing:1,),
                      )
                  ),

                ]
            ),
          ),
          Flexible(

              child: ListView.builder(itemCount: _listOfAddress != null ? _listOfAddress.length : 0 ,itemBuilder: (context,index){
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child:Text(
                            _listOfAddress[index].type,
                            style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10.0,top: 7.0,bottom: 5.0),
                          child:Text(
                            _listOfAddress[index].fullAddress,
                            style: TextStyle(fontSize: 14,color: Colors.black),
                          )
                      ),
                      Divider(
                          color: Colors.black
                      )
                    ]
                );
              },
            )
          ),
          ],
        ),
      ),
    );
  }

}



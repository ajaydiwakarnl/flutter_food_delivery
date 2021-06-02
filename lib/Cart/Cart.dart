import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Cart/CartModel.dart';
import 'package:food_delivery/Cart/CartService.dart';
import 'package:food_delivery/Cart/EmptyCart.dart';
import 'package:food_delivery/NearbyYou/NearbyYou.dart';
import 'package:food_delivery/NearbyYou/RestaurantDetail/DishModel.dart';
import 'package:food_delivery/NearbyYou/RestaurantDetail/DishService.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String _selectedTip,_to_pay ;
  OutletDetails _outletDetails;
  Address _getAddress;
  List<CartDish> _getdishes ;
  List<BillTotal> _billTotals ;
  Dishes _dishes;
  int _quantity = 0;
  List<dishesArray> dishesItem = [];
  String _udId,_outletId;

  @override
  void initState(){
    super.initState();
    setState(() {
      this.getViewCart();
    });
  }
  Future<void>getViewCart() async {
    CartRequest cartRequest  = new CartRequest();
    CartService cartService = new CartService();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String addressId = prefs.getString('addressId').toString();

    cartRequest.udId = prefs.getString('udid');
    cartRequest.addressId = addressId;

    var response = await cartService.ViewCart(cartRequest);
    if(response.error == "true"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmptyCart()));
    }else{
      if(response.dishes.outletDetails != null){
        setState(() {
          _outletDetails = response.dishes.outletDetails;
          _getdishes = response.dishes.dishes;
          _billTotals = response.dishes.billTotals;
          var length = _billTotals.length;
          _to_pay = _billTotals[length-1].displayValue;
          _dishes = response.dishes;
          _getAddress = response.dishes.address;
          _outletId = _outletDetails.outletId.toString();
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
          iconSize: 15,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.network(
                            _outletDetails != null ? _outletDetails.outletImage : "http://44.242.96.167/foodapp/public/images/Restaurant/image39101.jpg",
                            width: 50,
                            height: 50,
                            fit:BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                  Container(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(_outletDetails != null ? _outletDetails.outletName : "", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Proxima_Nova_ScOsf_Bold")),
                        ),
                        Container(
                            child:Text(_outletDetails != null ? _outletDetails.outletArea : "", style: TextStyle(fontSize: 14, fontFamily:'Proxima_Nova_Alt_Light', color: Colors.black))
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                child: Column(
                  children: [
                    if(_getdishes !=null)
                      for(var  i in _getdishes)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child:
                                  i.isVeg == 1 ? Image.asset("assets/images/veg.png",width: 15,height: 15)
                                      :Image.asset("assets/images/non_veg.png",width: 15,height: 15),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                      i != null ?  i.dishName : "",
                                      style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: "Proxima_Nova_Alt_Light",fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color:Colors.deepOrange,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              i.dishQuantity = i.dishQuantity + 1;
                                            });

                                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                                            _udId = prefs.getString('udid');

                                            UpdateCartApi(_outletId,i.dishQuantity.toString(),i.cartId.toString(),_udId);


                                          },
                                          child:  Container(
                                            child:Image.asset("assets/images/add.png",width: 12,height: 12),
                                            padding: EdgeInsets.all(5),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          child: Text(
                                              i!=null ? i.dishQuantity.toString() : "",
                                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500,
                                                  fontFamily: "Proxima_Nova_Bold")),
                                        ),
                                        GestureDetector(
                                          onTap:() async {
                                            setState(() {
                                              i.dishQuantity = i.dishQuantity - 1;
                                            });

                                            if(i.dishQuantity != 0){
                                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                                              _udId = prefs.getString('udid');

                                              UpdateCartApi(_outletId,i.dishQuantity.toString(),i.cartId.toString(),_udId);
                                            }else{
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmptyCart()));
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(6),
                                              child:Image.asset("assets/images/less.png",width: 13,height: 13)
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 15,top:5),
                                ),
                                Container(
                                  child: Text(
                                    i!=null ?i.dishPrice.toString() : "",
                                    style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: "Proxima_Nova_Alt_Light",fontWeight: FontWeight.bold),
                                  ),
                                  padding: EdgeInsets.only(right: 10),
                                ),
                              ],
                            )
                          ],
                        )


                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.description,color:Colors.deepOrange),
                          ),
                        ),
                        Expanded(
                          child: new TextFormField(
                            cursorColor: Colors.deepOrange,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText:Strings.any_restaurant_required,
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontFamily:'Proxima_Nova_Alt_Light',
                                  color: Colors.black54,)
                            ),

                          ),
                        ),
                      ],
                    ),
                  )

              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.money,color:Colors.deepOrange),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:  Text(
                                  Strings.maketip,
                                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,
                                      fontFamily: "Proxima_Nova_ScOsf_Bold"),
                                ),
                                margin: EdgeInsets.only(top:10),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:5),
                                child: Text(
                                  Strings.thank_you_tip,
                                  style: TextStyle(fontSize: 14, fontFamily:'Proxima_Nova_Alt_Light',color: Colors.black54,),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedTip = "30";
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                color: _selectedTip == "30" ? Colors.deepOrange : Colors.white,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: Text(
                                                        Strings.indian_rupess + "30",
                                                        style: TextStyle(fontSize: 14, color: _selectedTip == "30" ? Colors.white : Colors.deepOrange, fontWeight: FontWeight.w500,
                                                            fontFamily: "Proxima_Nova_ScOsf_Bold"),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectedTip = "";
                                                    });
                                                  },
                                                  icon: Icon(Icons.cancel,size: 15,color:Colors.white),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedTip = "50";
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                color: _selectedTip == "50" ? Colors.deepOrange : Colors.white,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: Text(
                                                        Strings.indian_rupess + "50",
                                                        style: TextStyle(fontSize: 14, color: _selectedTip == "50" ? Colors.white : Colors.deepOrange, fontWeight: FontWeight.w500,
                                                            fontFamily: "Proxima_Nova_ScOsf_Bold"),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectedTip = "";
                                                    });
                                                  },
                                                  icon: Icon(Icons.cancel,size: 15,color:Colors.white),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedTip = "70";
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                color: _selectedTip == "70" ? Colors.deepOrange : Colors.white,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: Text(
                                                        Strings.indian_rupess + "70",
                                                        style: TextStyle(fontSize: 14, color: _selectedTip == "70" ? Colors.white : Colors.deepOrange, fontWeight: FontWeight.w500,
                                                            fontFamily: "Proxima_Nova_ScOsf_Bold"),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectedTip = "";
                                                    });
                                                  },
                                                  icon: Icon(Icons.cancel,size: 15,color:Colors.white),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedTip = "other";
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Card(
                                                color: _selectedTip == "other" ? Colors.deepOrange : Colors.white,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: Text(
                                                        "Other",
                                                        style: TextStyle(fontSize: 14, color: _selectedTip == "other" ? Colors.white : Colors.deepOrange, fontWeight: FontWeight.w500,
                                                            fontFamily: "Proxima_Nova_ScOsf_Bold"),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectedTip = "";
                                                    });
                                                  },
                                                  icon: Icon(Icons.cancel,size: 15,color:Colors.white),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )

              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                margin: EdgeInsets.only(left:10,top:6),
                padding: EdgeInsets.all(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child:  Row(
                        children: [
                          Container(
                            child: Image.asset("assets/images/cupon.png",width: 25,height: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(left:20),
                            child:Text(
                              Strings.apply_cupon,
                              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,
                                  fontFamily: "Proxima_Nova_ScOsf_Bold"),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios,color:Colors.deepOrange),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                child:  Column(

                  children: [
                    if(_billTotals !=null)
                      for(var  i in _billTotals)
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                    i.displayKey,
                                    style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Proxima_Nova_Bold")),
                              ),
                              Container(
                                child: Text(
                                    i.displayValue,
                                    style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Proxima_Nova_Bold")
                                ),
                              ),
                            ],
                          ),
                        )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:Container(
        height: 122,
        child: Column(
           children: [
             if(_dishes != null)
              _dishes.isAddress == false ?
             Stack(
               children: <Widget>[
                 Card(
                   margin: EdgeInsets.zero,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                       const ListTile(
                         leading: Icon(Icons.home_outlined, size: 35,color: Colors.deepOrange,),
                         title: Text(
                           "Deliver to Home",
                           style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500,
                               fontFamily: "Proxima_Nova_ScOsf_Bold"),
                         ),
                         subtitle: Text(
                           "Unnamed Road",
                           style: TextStyle(fontSize: 14, fontFamily:'Proxima_Nova_Alt_Light',color: Colors.black54,),
                         ),

                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 22,
                   right: 10,
                   child: Text(
                     Strings.managed_address,
                     style: TextStyle(fontSize: 14, color: Colors.deepOrange, fontWeight: FontWeight.w500,
                         fontFamily: "Proxima_Nova_ScOsf_Bold"),
                   ),
                 ),
               ],
             ) :
             Stack(
               children: <Widget>[
                 Card(
                   margin: EdgeInsets.only(top:12),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                        ListTile(
                         leading: Icon(Icons.home_outlined, size: 35,color: Colors.deepOrange,),
                         title: Container(
                           child: Text(
                             _getAddress.name,
                             style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500,
                                 fontFamily: "Proxima_Nova_ScOsf_Bold"),
                           ),
                         ),
                         subtitle:Container(
                            padding: EdgeInsets.only(top:6),
                            child: Text(
                              _getAddress.address,
                              style: TextStyle(fontSize: 14, fontFamily:'Proxima_Nova_Alt_Light',color: Colors.black54,),
                            ),
                         ),
                        )
                     ],
                   ),
                 ),
                 Positioned(
                   top: 15,
                   right: 6,
                   child: Text(
                    Strings.change_address,
                     style: TextStyle(fontSize: 14, color: Colors.deepOrange, fontWeight: FontWeight.w500,
                         fontFamily: "Proxima_Nova_ScOsf_Bold"),
                   ),
                 ),
               ],
             ),
             Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                     flex:5,
                     child: Column(
                       children: [
                         Container(
                           height: 50,
                           color: Colors.white70,
                           alignment: Alignment.center,
                           child:  Column(
                             children: [
                               Container(
                                 padding: const EdgeInsets.only(top:8.0),
                                 child: Text( _to_pay!=null ? _to_pay : "", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Proxima_Nova_ScOsf_Bold",), textAlign: TextAlign.center,),
                               ),
                               Container(
                                 child:  Text( "To Pay", style: TextStyle(fontSize: 14, color: Colors.deepOrange, fontWeight: FontWeight.w500, fontFamily: "Proxima_Nova_ScOsf_Bold"), textAlign: TextAlign.center,),
                               )

                             ],
                           ),
                         ),

                       ],
                     )
                   ),
                   Expanded(
                     flex:5,
                     child:Container(
                       height: 50,
                       color: Colors.deepOrange,
                       alignment: Alignment.center,
                       child: Text(
                         Strings.proceed_to_pay,
                         style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,
                             fontFamily: "Proxima_Nova_ScOsf_Bold"),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ],
        ),
      ),
    );
  }

  UpdateCartApi(_outletId, _quantity,_cartId,_udId) async {

    UpdateCartRequest updateCartRequest = new UpdateCartRequest();
    CartService cartService = new CartService();
    updateCartRequest.outletId = _outletId;
    updateCartRequest.quantity = _quantity;
    updateCartRequest.cartId = _cartId;
    updateCartRequest.udId = _udId;

    var response = await cartService.UpdateCart(updateCartRequest);
    if(response.error == "false"){
      setState(() {
        this.getViewCart();
      });

    }

  }
}



class dishesArray{
  int quantity;
  List<dynamic> customisation;
  String uuId;
  int dishId;

  dishesArray( { this.quantity, this.customisation, this.uuId, this.dishId });

  Map toJson() => {
    'quantity': quantity,
    'customisation': customisation,
    'uuId': uuId,
    'dishId': dishId,
  };
}

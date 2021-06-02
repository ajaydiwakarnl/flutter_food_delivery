
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery/Cart/Cart.dart';
import 'package:food_delivery/NearbyYou/RestaurantDetail/DishModel.dart';
import 'package:food_delivery/NearbyYou/RestaurantDetail/DishService.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RestaurantMenu extends StatefulWidget {
  final int outletId;

  const RestaurantMenu({Key key, this.outletId}) : super(key: key);
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {

  List <Dish> _listDish;
  List <CategoryValue> _categoryValues;
  List<CouponDetail>  _couponList;
  Outlets _getOutlet;
  getOutletResponse _outletResponse;
  CouponResponse _couponResponse;
  List <Item> _data = generateItems(0);
  int _length  = 0,_cuponLength = 0, _noOfQuantity = 0,_displayPrice = 0;
  String _udId,_sendoutletId;
  //List<Map<String, dynamic>>  _dishes ;
  bool viewVisible = true ;
  List<dishesArray> dishesItem = [];

  void showWidget(){
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }



  void initState(){
    setState(() {
      int _outletId = widget.outletId;
      this.getListOfDish(_outletId.toString());
      this.getOutlet(_outletId.toString());
      this.getCouponList(_outletId.toString());
      _sendoutletId = _outletId.toString();
    });
  }


  getListOfDish(String _outletId) async {
      DishRequest dishRequest = new DishRequest();
      DishService dishService = new DishService();
      dishRequest.outletId = _outletId;

      var response = await dishService.listdishes(dishRequest);
      if(response.dishes != null){
        _listDish = response.dishes;
      }else{
        _listDish = [];
      }

      setState(() {
        _listDish ;
        log(_listDish.length.toString());
        _length = _listDish.length != null ? _listDish.length: 0;
        _data = generateItems(_length);


      });
  }


  getCouponList(String _outletId) async {
    getOutletRequest outletRequest = new getOutletRequest();
    DishService dishService = new DishService();
    outletRequest.outletId = _outletId;

    var response = await dishService.getCouponList(outletRequest);
    if(response.couponDetails != null){
      _couponList = response.couponDetails;
    }else{
      _couponList = [];
    }

    setState(() {
      _couponList;
      _cuponLength = _couponList.length;
      _couponResponse = response;
    });
  }

  getOutlet(String _outletId) async {
    DishService dishService = new DishService();
    var response = await dishService.getOutlet(_outletId);

    setState(() {
      if(response.outlets != null){
        _getOutlet = response.outlets;
        _outletResponse = response;
        log("RESNAME" +_getOutlet.outletName);
      }
    });

  }

  Widget _buildListPanel(){
      final panel = ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int index, bool isExpanded){
        setState(() {
           _data[index].isExpanded = !isExpanded;
         });
        },

        children: _data.map<ExpansionPanel>((Item item){
            var index = _data.indexOf(item);
            setState(() {
              _categoryValues = _listDish[index].categoryValues;
            });

            return ExpansionPanel(
              backgroundColor: Color(0X000),
              headerBuilder: (BuildContext context , bool isExpanded){
                return ListTile(
                  title: Text(
                  _listDish[index].categoryName,
                    style: TextStyle(fontSize: 22, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.black,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                );
              },
                body: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          for(var _category   in _categoryValues)
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Card(
                                      elevation: 2,
                                      margin: EdgeInsets.all(10.0),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            child:Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child:
                                                  _category.isVeg != 1 ?
                                                    Image.asset("assets/images/non_veg.png",width: 15,height: 15) :
                                                    Image.asset("assets/images/veg.png",width: 15,height: 15)
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top:6),
                                                  child: Text(
                                                      _category.dishName,
                                                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,
                                                      fontFamily: "Proxima_Nova_Bold")),
                                                ),
                                                if(_category.slashedPrice != 0)
                                                  Container(
                                                    margin: EdgeInsets.only(top:5),
                                                      child:Text(
                                                          _category.slashedPrice.toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:'Proxima_Nova_Alt_Light',
                                                              color: Colors.black54,fontWeight: FontWeight.bold,
                                                              decoration: TextDecoration.lineThrough)
                                                      )
                                                  ),
                                                Container(
                                                    margin: EdgeInsets.only(top:2),
                                                    child:Text(
                                                        _category.displayPrice,
                                                        style: TextStyle(fontSize: 14,
                                                            fontFamily:'Proxima_Nova_Alt_Light',
                                                            color: Colors.black54,fontWeight: FontWeight.bold)
                                                    )
                                                ),
                                                Container(
                                                        margin: EdgeInsets.only(top:8),
                                                        child:Text(
                                                            _category.description != null ? _category.description : "no description",
                                                            style: TextStyle(fontSize: 15,color: Colors.black54,
                                                              fontFamily:'ProximaNova_Regular',)
                                                        )
                                                    ),
                                              ],
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(20),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Image.network(
                                                    _category.dishImage != null ? _category.dishImage : item.dishImage,
                                                    width: 150,
                                                  ),
                                                ),
                                              ),
                                              _category.Counter == 0 ? Container(
                                                child: RaisedButton(
                                                  child: Text(Strings.Add, style: TextStyle(fontSize: 13)),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4.0),
                                                      side: BorderSide(color: Colors.deepOrange)
                                                  ),
                                                  disabledColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  color:Colors.deepOrange,
                                                  onPressed: () async {
                                                    setState(() {
                                                      _category.Counter = _category.Counter +1;
                                                      _noOfQuantity = _noOfQuantity + _category.Counter;
                                                      _displayPrice = _displayPrice + _category.price;
                                                    });

                                                    var uuid = Uuid();


                                                    dishesArray array = dishesArray(
                                                        quantity:_category.Counter,
                                                        customisation: [],
                                                        uuId: uuid.v4(),
                                                        dishId:_category.dishId
                                                    );


                                                    dishesItem.add(array);
                                                    showWidget();
                                                  },
                                                ),
                                              ) :
                                              Container(
                                                width: 100,
                                                height: 40,
                                                margin: EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    color:Colors.deepOrange,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {

                                                        setState(() {
                                                          _category.Counter = _category.Counter + 1;
                                                          _noOfQuantity = _noOfQuantity + 1;
                                                          _displayPrice = _displayPrice + _category.price;
                                                        });

                                                        final index = dishesItem.indexWhere((element) => element.dishId == _category.dishId);
                                                        log(index.toString());
                                                        dishesItem[index].quantity = _category.Counter;
                                                      },
                                                      child:  Container(
                                                        child:Image.asset("assets/images/add.png",width: 13,height: 13),
                                                        padding: EdgeInsets.all(6),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(6),
                                                      child: Text(
                                                          _category.Counter.toString(),
                                                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500,
                                                              fontFamily: "Proxima_Nova_Bold")),
                                                    ),
                                                    GestureDetector(
                                                      onTap:() async {
                                                        setState(() {
                                                          _category.Counter = _category.Counter - 1;
                                                          _noOfQuantity = _noOfQuantity - 1;
                                                          _displayPrice = _displayPrice -  _category.price;
                                                        });
                                                        final index = dishesItem.indexWhere((element) => element.dishId == _category.dishId);
                                                        dishesItem[index].quantity = _category.Counter;
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.all(6),
                                                          child:Image.asset("assets/images/less.png",width: 13,height: 13)
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                )
                              ],
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              isExpanded: item.isExpanded
            );
        }).toList(),
      );
      return ClipRect(child: panel);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:20,left: 20),
                child:  Container(
                  child: Text(
                   _getOutlet != null ? _getOutlet.outletName : "",
                    style: TextStyle(fontSize: 25, fontFamily:'Proxima_Nova_Extra_Condensed_Bold', color: Colors.black,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:5,left: 20),
                child:  Container(
                  child: Text(
                    _getOutlet != null ? _getOutlet.addressLineOne : "",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:5,left: 20),
                child:  Container(
                  child: Text(
                    _getOutlet != null ? _getOutlet.addressLineTwo + "," +_getOutlet.street : "" ,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily:'Proxima_Nova_Alt_Light',
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child:Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: [
                            Icon(Icons.star,color: Colors.black,size:15,),
                            Text(
                              "Too few Rating",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily:'Proxima_Nova_Alt_Light',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: [
                          Text(
                            "Closed",
                            style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.deepOrange),
                          ),
                          Text(
                            "For Delivery",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily:'Proxima_Nova_Alt_Light',
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    ),
                    Flexible(
                      child:  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        children: [
                          Text(
                            _getOutlet != null ? _outletResponse.currency + _getOutlet.costForTwo.toString() : "",
                            style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.black),
                          ),
                          Text(
                            "Cost for two",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily:'Proxima_Nova_Alt_Light',
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    )

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              _cuponLength !=0 ?
                Container(
                height:100,
                margin: EdgeInsets.only(left: 5,right: 5),
                child:
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _couponList != null ? _couponList.length : 0,
                    itemBuilder: (context, index) {
                      return  Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Image.asset("assets/images/cupon.png",width: 25,height: 25),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(child:  Container(
                                      margin: EdgeInsets.only(top:30),
                                      child: Text(
                                        "40 % OFF UPTO 150",
                                        style: TextStyle(fontSize: 12, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.black,fontWeight: FontWeight.w500),

                                      ),

                                    ),),
                                    Flexible(child:  Container(
                                      margin: EdgeInsets.only(top:2),
                                      child: Text(
                                        _couponList != null ? _couponList[index].couponDescription : "",
                                        style: TextStyle(fontSize: 12,color: Colors.black54,
                                            fontFamily:'ProximaNova_Regular'),
                                        textAlign: TextAlign.center,
                                      ),

                                    ),)

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  )
              )
                  :
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Coupon is not available" ,
                  style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_Alt_Light', color: Colors.black),

                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                    color: Colors.grey
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                child: _buildListPanel(),
              ),


            ],
          ),

        ),
      ),
      bottomNavigationBar:
       _noOfQuantity != 0 ? Container(
        color: Colors.black,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.only(left: 20),
                child:Text(
                    _noOfQuantity.toString() + " items  | " + _displayPrice.toString(),
                    style: TextStyle(fontSize: 16,color: Colors.white, fontFamily:'Proxima_Nova_Bold',)
                )
            ),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    _udId = prefs.getString('udid');


                    addToCartApi(_sendoutletId, dishesItem, _udId);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Cart()));
                  },
                  child: Text(
                      Strings.view_cart,
                      style: TextStyle(fontSize: 14,color: Colors.white, fontFamily:'Proxima_Nova_Bold',)
                  ),
                ),
            ),
          ],
        ),
      ) : Container(height: 0,),
    );
  }

  addToCartApi(_outletId, List<dishesArray>_dishes,_udId) async {

    AddToCartRequest addToCartRequest = new AddToCartRequest();
    DishService dishService = new DishService();
    addToCartRequest.outletId = _outletId;
    addToCartRequest.dishes = jsonEncode(_dishes);
    addToCartRequest.udId = _udId;

    var response = await dishService.addtoCart(addToCartRequest);
    return response.error;
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


class Item {
  String dishCategoryName;
  String dishName;
  String dishImage;
  String dishPrice;
  String dishSlashPrice;
  bool isExpanded;
  Item({ this.dishCategoryName,  this.dishName ,this.dishImage, this.dishPrice, this.dishSlashPrice, this.isExpanded = false });
}

List<Item> generateItems (int noOfItems){

  return List.generate(noOfItems, (index){
    return Item(
      dishCategoryName  :  "",
      dishName          :  "Pizza Onion",
      dishImage         :  "http://44.242.96.167/foodapp/public/images/dishes/image51563.jpeg",
      dishPrice         :  "200",
      dishSlashPrice    :  "250",
    );
  });
}


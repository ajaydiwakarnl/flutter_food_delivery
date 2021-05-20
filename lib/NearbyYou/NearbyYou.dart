import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/NearbyYou/ListRestaurantService.dart';
import 'package:food_delivery/NearbyYou/RestaurantDetail/RestaurantMenu.dart';
import 'package:food_delivery/SetDeliveryLocation/SetDeliveryLocation.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListRestaurantModel.dart';

class NearbyYou extends StatefulWidget {
  @override
  _NearbyYouState createState() => _NearbyYouState();
}

class _NearbyYouState extends State<NearbyYou> {
  bool _isLoading = false;
  List<ListRestaurant> _listRestaurant;
  List<UserAddress> _userAddress;
  List<Outlet> _listOutlet;
  Location _location = Location();
  LocationData _currentLocation;
  String getCurrentAddress,getTagName,udId,latitude,longtitude;

  @override
  void initState(){
    super.initState();
     setState(() {
       this.CurrentAddress();
       _isLoading = true;
     });

  }

  callListRestaurantApi(_udId,_latitude,_longitude,_pageNumber) async {
      setState(() {
        _isLoading = true;
      });
    ListRestaurantRequest listRestaurantRequest = new ListRestaurantRequest();
    ListRestaurantService listRestaurantService = new ListRestaurantService();
    listRestaurantRequest.udId = _udId;
    listRestaurantRequest.latitude = _latitude;
    listRestaurantRequest.longitude = _longitude;
    listRestaurantRequest.pageNumber = _pageNumber;
    var response = await listRestaurantService.ListRestaurant(listRestaurantRequest);

    if(response.listRestaurants != null){
      _listRestaurant = response.listRestaurants;
    }else{
      _listRestaurant = [];
    }

    if(response.address != null){
      _userAddress = response.address;
    }
    setState(() {
      _listRestaurant;
      _userAddress;
    });
  }

  CurrentAddress() async {
    _currentLocation = await _location.getLocation();
    final _coordinates = new Coordinates(_currentLocation.latitude, _currentLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(_coordinates);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(()  {
      getCurrentAddress = addresses.first.addressLine;
      getTagName = addresses.first.locality;
      udId =  prefs.get("udid");
      latitude = _currentLocation.latitude.toString();
      longtitude = _currentLocation.longitude.toString();

      this.callListRestaurantApi(udId, latitude, longtitude, "1");
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetDeliveryLocation()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child:
                    getTagName != null ?
                    Text( _userAddress != null ? _userAddress[0].type.toUpperCase() : getTagName,
                      style: TextStyle(fontSize: 20, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500),
                    ) :
                    Text( _userAddress != null ? _userAddress[0].type.toUpperCase() : "WORKING",
                      style: TextStyle(fontSize: 20, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500),
                    ) ,
                  ),
                  Container(
                    child:
                    getCurrentAddress != null ?
                    Text( _userAddress != null ? _userAddress[0].fullAddress : getCurrentAddress,
                      style: TextStyle(fontSize: 14,
                          fontFamily:'Proxima_Nova_Alt_Light',
                          color: Colors.black),
                    ) :
                    Text( _userAddress != null ? _userAddress[0].fullAddress : "Loading...",
                      style: TextStyle(fontSize: 14,
                          fontFamily:'Proxima_Nova_Alt_Light',
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: Colors.black,

            ),
          )
        ],

      ),
      body: Container(
          child:ListView.builder(
              itemCount: _listRestaurant != null ? _listRestaurant.length : 0 ,itemBuilder: (context,index){
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if( index == 0)
                    Container(
                    margin: EdgeInsets.only(top:20,left: 10,),
                    child: Text(
                        Strings.all_restaturant,
                        style: TextStyle(fontSize: 20, fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500)
                    ),
                  ),
                  if( index == 0)
                    Container(
                    margin: EdgeInsets.only(left: 10,bottom: 10),
                    child: Text(
                        Strings.discover_unique_tast,
                        style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_Alt_Light', color: Colors.black,fontWeight: FontWeight.w500)
                    ),
                  ),

                  Container(
                    child: Column(
                      children: [
                        Column(
                          children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: (){
                                        log(_listRestaurant[index].outlet[0].outletName);
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => RestaurantMenu(outletId:_listRestaurant[index].outlet[0].outletId)),);
                                      },
                                     child: Row(
                                       children: [
                                         Stack(
                                           alignment: Alignment.bottomCenter,
                                           children: <Widget>[
                                             Container(
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(6.0),
                                                 child: Image.network(
                                                   _listRestaurant[index].restaurantImage,
                                                   width: 120,
                                                   height: 120,
                                                   fit:BoxFit.fill,
                                                 ),
                                               ),
                                               padding: EdgeInsets.all(10),
                                             ),
                                             Container(
                                               child: RaisedButton(
                                                 child: Text("50% OFF", style: TextStyle(fontSize: 18,fontFamily:'Proxima_Nova_ScOsf_Bold', color: Colors.black,fontWeight: FontWeight.w500)),
                                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),
                                                     side: BorderSide(color: Colors.deepOrange)),
                                                 disabledColor: Colors.grey,
                                                 textColor: Colors.white,
                                                 color:Colors.white,
                                                 onPressed: () async {
                                                 },
                                               ),
                                             )
                                           ],
                                         ),
                                         Container(
                                           margin: EdgeInsets.all(10),
                                           child:Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Container(
                                                 margin: EdgeInsets.only(top:6),
                                                 child: Text(
                                                     _listRestaurant[index].restaurantName,
                                                     style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500,
                                                         fontFamily: "Proxima_Nova_ScOsf_Bold")),
                                               ),

                                               Container(
                                                   margin: EdgeInsets.only(top:5),
                                                   child:Text(
                                                       "Old Jodhpur",
                                                       style: TextStyle(
                                                           fontSize: 15,
                                                           fontFamily:'Proxima_Nova_Alt_Light',
                                                           color: Colors.black54,fontWeight: FontWeight.bold)
                                                   )
                                               ),
                                               Container(
                                                 margin: EdgeInsets.only(top:2),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Container(
                                                       padding: EdgeInsets.only(top:5,right:5 ),
                                                       child: Column(
                                                         children: [
                                                           Icon(Icons.star,color: Colors.black,size:15,),
                                                         ],
                                                       ),
                                                     ),
                                                     Container(
                                                       padding: EdgeInsets.only(top:5,right:5 ),
                                                       child: Column(
                                                         children: [
                                                           Text(
                                                             _listRestaurant[index].averageReview,
                                                             style: TextStyle(fontSize: 13, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.green),
                                                           ),

                                                         ],
                                                       ),
                                                     ),
                                                     Container(
                                                       padding: EdgeInsets.only(top:5,right:5,left:5 ),
                                                       child: Column(
                                                         children: [
                                                           Text(
                                                             _listRestaurant[index].displayTime ,
                                                             style: TextStyle(fontSize: 13, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.deepOrange),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                     Container(
                                                       padding: EdgeInsets.only(top:5,right:5,left:5 ),
                                                       child: Column(
                                                         children: [
                                                           Text(
                                                             _listRestaurant[index].costForTwo.toString() + " for two",
                                                             style: TextStyle(fontSize: 15, fontFamily:'Proxima_Nova_Alt_Bold', color: Colors.black),
                                                           ),
                                                         ],
                                                       ),
                                                     ),


                                                   ],
                                                 ),

                                               ),
                                               Container(
                                                   margin: EdgeInsets.only(top:8),
                                                   child:Text(
                                                       _listRestaurant[index].shortDescription != null ? _listRestaurant[index].shortDescription : "",
                                                       style: TextStyle(fontSize: 15,color: Colors.black54,
                                                         fontFamily:'ProximaNova_Regular',)
                                                   )
                                               ),
                                             ],
                                           ),
                                         ),

                                       ],
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
                ],
              ),
            );
          })
      )

    );
  }
}




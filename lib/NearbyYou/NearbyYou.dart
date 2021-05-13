import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/NearbyYou/ListRestaurantService.dart';
import 'package:food_delivery/SetDeliveryLocation/SetDeliveryLocation.dart';
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
    }else{
      _userAddress = [];
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
        backgroundColor: Colors.blue,
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
                      style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal),
                    ) :
                    Text( _userAddress != null ? _userAddress[0].type.toUpperCase() : "WORKING",
                      style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal),
                    ) ,
                  ),
                  Container(
                    child:
                    getCurrentAddress != null ?
                    Text( _userAddress != null ? _userAddress[0].fullAddress : getCurrentAddress,
                      style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),
                    ) :
                    Text( _userAddress != null ? _userAddress[0].fullAddress : "Loading...",
                      style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.normal),
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
              color: Colors.white,

            ),
          )
        ],

      ),
      body: ListView.builder(itemCount: _listRestaurant != null ? _listRestaurant.length : 0 ,itemBuilder: (context,index){
        return Card(
            margin: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  child: Image.network(
                      _listRestaurant[index].restaurantImage,
                      height: 150,
                      fit:BoxFit.fill
                  ),
                ),
                ListTile(
                    title: Text(_listRestaurant[index].restaurantName , style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
                    subtitle: Text(_listRestaurant[index].shortDescription != null ? _listRestaurant[index].shortDescription : " ",style: TextStyle(fontSize: 13,color: Colors.orange))
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left:14.0,bottom: 10.0),
                      child:Text(_listRestaurant[index].displayTime,style: TextStyle(fontSize: 13,color: Colors.black)),
                    ),
                    Container(
                      width: 65.0,
                      height: 25.0,
                      margin: EdgeInsets.only(left: 20.0,bottom: 10.0),
                      child: RaisedButton.icon(
                        label: Text(_listRestaurant[index].averageReview, style: TextStyle(fontSize: 13)),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        disabledColor: Colors.grey,
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.star,size: 10,color: Colors.white,),
                        onPressed: () {},
                      ),
                    )
                  ],
                )

              ]
          )
        );
      })
    );
  }
}




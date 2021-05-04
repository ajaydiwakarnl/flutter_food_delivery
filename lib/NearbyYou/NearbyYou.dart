import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/NearbyYou/ListRestaurantService.dart';
import 'ListRestaurantModel.dart';

class NearbyYou extends StatefulWidget {
  @override
  _NearbyYouState createState() => _NearbyYouState();
}

class _NearbyYouState extends State<NearbyYou> {
  bool _isLoading = false;
  List<ListRestaurant> _listRestaurant;
  @override
  
  void initState(){
    super.initState();
    this.callListRestaurantApi("73CC2846-F4A8-42A1-A498-FAD815FD6649", "23.09212", "72.09212", "1 ");
  }


  callListRestaurantApi(_udId,_latitude,_longitude,_pageNumber) async {
    ListRestaurantRequest listRestaurantRequest = new ListRestaurantRequest();
    ListRestaurantService listRestaurantService = new ListRestaurantService();
    listRestaurantRequest.udId = _udId;
    listRestaurantRequest.latitude = _latitude;
    listRestaurantRequest.longitude = _longitude;
    listRestaurantRequest.pageNumber = _pageNumber;
    var response = await listRestaurantService.ListRestaurant(listRestaurantRequest);
    if(response.listRestaurants.isNotEmpty){
      _listRestaurant = response.listRestaurants;
    }else{
      _listRestaurant = [];
    }
    setState(() {
      _listRestaurant;
    });

  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView.builder(itemCount: _listRestaurant != null ? _listRestaurant.length : 0 ,itemBuilder: (context,index){
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
      }),
    );
  }
}




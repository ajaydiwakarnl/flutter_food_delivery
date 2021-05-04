import 'package:flutter/material.dart';
import 'package:food_delivery/Account/Account.dart';
import 'package:food_delivery/Cart/Cart.dart';
import 'package:food_delivery/Explore/Explore.dart';
import 'package:food_delivery/NearbyYou/ListRestaurantModel.dart';
import 'package:food_delivery/NearbyYou/ListRestaurantService.dart';
import 'package:food_delivery/NearbyYou/NearbyYou.dart';
import 'package:food_delivery/SetDeliveryLocation/SetDeliveryLocation.dart';
import 'package:food_delivery/String/Strings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Address> _userAddress;

  void initState(){
    super.initState();
    this.getUserAddress("73CC2846-F4A8-42A1-A498-FAD815FD6649", "23.09212", "72.09212", "1 ");
  }
  getUserAddress(_udId,_latitude,_longitude,_pageNumber) async {
    ListRestaurantRequest listRestaurantRequest = new ListRestaurantRequest();
    ListRestaurantService listRestaurantService = new ListRestaurantService();
    listRestaurantRequest.udId = _udId;
    listRestaurantRequest.latitude = _latitude;
    listRestaurantRequest.longitude = _longitude;
    listRestaurantRequest.pageNumber = _pageNumber;
    var response = await listRestaurantService.ListRestaurant(listRestaurantRequest);
    if(response.address.isNotEmpty){
      _userAddress = response.address;
    }else{
      _userAddress = [];
    }
    setState(() {
      _userAddress;
    });

  }
  final List<Widget> _navigateScreen =[
      NearbyYou(),
      Explore(),
      Cart(),
      Account()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                      child:Text(_userAddress != null ? _userAddress[0].type.toUpperCase() : "Test",
                        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      child: Text(_userAddress != null ? _userAddress[0].fullAddress : "Test",
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
      body: Container(
          child: _navigateScreen.elementAt(_selectedIndex),

      ),

      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(Strings.bottom_nav_near_you),
                backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(Strings.bottom_explore),
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text(Strings.bottom_cart),
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(Strings.bottom_account),
                backgroundColor: Colors.green
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}

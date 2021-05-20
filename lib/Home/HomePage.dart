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

  void initState(){
    super.initState();
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
      body: Container(
          child: _navigateScreen.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(Strings.bottom_nav_near_you,
                  style: TextStyle(fontSize: 13, fontFamily:'Proxima_Nova_ScOsf_Bold',fontWeight: FontWeight.w500),),
                backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(Strings.bottom_explore,style: TextStyle(fontSize: 13, fontFamily:'Proxima_Nova_ScOsf_Bold',fontWeight: FontWeight.w500),),
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text(Strings.bottom_cart,style: TextStyle(fontSize: 13, fontFamily:'Proxima_Nova_ScOsf_Bold',fontWeight: FontWeight.w500),),
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(Strings.bottom_account,style: TextStyle(fontSize: 13, fontFamily:'Proxima_Nova_ScOsf_Bold',fontWeight: FontWeight.w500),),
                backgroundColor: Colors.green
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrange,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}

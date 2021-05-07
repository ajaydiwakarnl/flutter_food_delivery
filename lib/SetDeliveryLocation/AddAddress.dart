import 'package:flutter/material.dart';
import 'package:food_delivery/String/Strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GoogleMapController _googleMapController;
  LatLng _center = LatLng(20.5937, 78.9629);
  Location _location = Location();


  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    _location.onLocationChanged.listen((l) {
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _center),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,

            ),
          ),
          Container(
             decoration: new BoxDecoration(
                  color: Colors.black
             ),
            child:Container(
                margin: EdgeInsets.all(15.0),
                child:Text(
                  Strings.set_delivery_bottom,
                  style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal,letterSpacing: 0.1),
                )
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child:  new TextFormField(
              cursorColor: Colors.orange,
              decoration:  InputDecoration(
                labelText: Strings.location,
                labelStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child:  new TextFormField(
              cursorColor: Colors.orange,
              decoration:  InputDecoration(
                labelText: Strings.apt_suite,
                labelStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0,right: 20.0),
            child:  new TextFormField(
              cursorColor: Colors.orange,
              decoration:  InputDecoration(
                labelText: Strings.landmark,
                labelStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54)
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20.0,top: 20.0),
              child:Text(
                Strings.save_as,
                style: TextStyle(fontSize: 16,color: Colors.black45,fontWeight: FontWeight.normal),
              )
          ),
          Container(
            child: Row(
              children: [
                Flexible(
                  child:Container(
                    margin: EdgeInsets.only(left: 20.0,right: 20.0),
                    child:  new TextFormField(
                      cursorColor: Colors.orange,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(
                          Icons.home_outlined,
                          size: 20,
                          color: Colors.black45,
                        ),
                        labelText: Strings.home,
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child:Container(
                    margin: EdgeInsets.only(left: 20.0,right: 20.0),
                    child:  new TextFormField(
                      cursorColor: Colors.orange,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(
                          Icons.work_outline,
                          size: 20,
                          color: Colors.black45,
                        ),
                        labelText: Strings.work,
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child:Container(
                    margin: EdgeInsets.only(left: 20.0,right: 20.0),
                    child:  new TextFormField(
                      cursorColor: Colors.orange,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Colors.black45,
                        ),
                        labelText: Strings.other,
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54)
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top:20),
              decoration: new BoxDecoration(
                  color: Colors.deepOrange
              ),
              child:Container(
                  margin: EdgeInsets.all(15.0),
                  child:Text(
                    Strings.save,
                    style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.normal,letterSpacing: 0.1),
                    textAlign: TextAlign.center,
                  )
              )
          ),
        ],
      )
    );
  }
}

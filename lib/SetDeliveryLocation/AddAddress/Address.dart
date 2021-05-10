import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:food_delivery/String/Strings.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery/SetDeliveryLocation/AddAddress/AddressService.dart';
import 'package:food_delivery/SetDeliveryLocation/AddAddress/AddressModel.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GoogleMapController _googleMapController;
  LatLng _center = LatLng(20.5937, 78.9629);
  Location _location = Location();
  LocationData _currentLocation;
  double _latitude,_longitude;
  Set<Marker> _markers = {};
  TextEditingController _location_txt;
  BitmapDescriptor customMarkerIcon;
  final _formKey = GlobalKey<FormState>();
  String _latitude_val,_longitude_val,_location_val,_houseFlatNo_val,_landMark_val,_type_1_val;

  void initState () {
    super.initState();
    setState(() {
      this.setTextFieldsValue();
      this.setCustomMapPin();
    });
  }

  setCustomMapPin() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/marker.png');
  }


  setTextFieldsValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _latitude =  prefs.getDouble('latitude');
    _longitude =  prefs.getDouble('longitude');
    _currentLocation = await _location.getLocation();

    final _coordinates = new Coordinates(
        _latitude != null ? _latitude : _currentLocation.latitude,
        _longitude != null ? _longitude : _currentLocation.longitude);

    var addresses = await Geocoder.local.findAddressesFromCoordinates(_coordinates);
    _location_txt = new TextEditingController(text: addresses.first.addressLine);

    _latitude_val = (_latitude != null ? _latitude : _currentLocation.latitude) as String ;
    _longitude_val =  (_longitude != null ? _longitude : _currentLocation.longitude) as String;

    log(_currentLocation.latitude.toString());

    setState(() {
      _markers.add(
          Marker(
            markerId: MarkerId("ID-1"),
            position: LatLng(
                _latitude != null ? _latitude : _currentLocation.latitude,
                _longitude != null ? _longitude : _currentLocation.longitude
            ),
            infoWindow: InfoWindow(
              title: addresses.first.addressLine,
            ),
            icon:customMarkerIcon,
          )
      );
    });


  }

  Future<void> _onMapCreated(GoogleMapController controller)  async {
    _googleMapController = controller;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _latitude =  prefs.getDouble('latitude');
    _longitude =  prefs.getDouble('longitude');
    _currentLocation = await _location.getLocation();

    final _coordinates = new Coordinates(
        _latitude != null ? _latitude : _currentLocation.latitude,
        _longitude != null ? _longitude : _currentLocation.longitude);

    var addresses = await Geocoder.local.findAddressesFromCoordinates(_coordinates);

    _location.onLocationChanged.listen((l) {
      _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(
                _latitude != null ? _latitude : l.latitude,
                _longitude != null ? _longitude : l.longitude
            ),zoom: 15),
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
              markers: _markers,
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
          Form(
            key: _formKey,
            child:Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      child:  new TextFormField(
                        cursorColor: Colors.orange,
                        onSaved: (String val) => setState( () => _location_val = val),
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
                        controller: _location_txt,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      child:  new TextFormField(
                        cursorColor: Colors.orange,
                        onSaved: (String val) => setState( () => _houseFlatNo_val = val),
                        decoration:  InputDecoration(
                          labelText: Strings.house_no,
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
                        onSaved: (String val) => setState( () => _landMark_val = val),
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
                                onSaved: (String val) => setState( () => _type_1_val = val),
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
                                onSaved: (String val) => setState( () => _type_1_val = val),
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
                                onSaved: (String val) => setState( () => _type_1_val = val),
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

                  ],
                ),
            )
          ),
          new GestureDetector(
            onTap: () async {
              _formKey.currentState.save();
              AddressRequest  addressRequest = new AddressRequest();
              AddressService  addressService = new AddressService();

              addressRequest.latitude    = _latitude_val != null ? _latitude_val : "";
              addressRequest.longitude   = _longitude_val != null ? _longitude_val : "";
              addressRequest.location    = _location_val  != null ? _location_val : "";
              addressRequest.houseFlatNo = _houseFlatNo_val != null ? _houseFlatNo_val : "";
              addressRequest.landMark    = _landMark_val    != null ? _landMark_val : "";
              addressRequest.type_1      = _type_1_val != null ? _type_1_val : "";
              addressRequest.type_2      = _type_1_val != null ? _type_1_val : "";

              var response = await addressService.address(addressRequest);
              log(response.errorMessage);


            },
            child:Container(
                margin: EdgeInsets.only(top:20),
                width: 100,
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
          )
        ],
      )
    );
  }
}

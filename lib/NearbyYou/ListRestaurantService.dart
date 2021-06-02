import 'dart:developer';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:food_delivery/Repository/StoreApiResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery/ApiList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListRestaurantModel.dart';

class ListRestaurantService{

  Future<bool> setLatitude(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('latitude', value);
  }

  Future<double> getLatitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('latitude');
  }


  Future<bool> setLongitude(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('longitude', value);
  }

  Future<double> getLongitude() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('longitude');
  }


  Future <ListRestaurantResponse>ListRestaurant(ListRestaurantRequest listRestaurantRequest) async {
    String URL = ApiList.LISTRESTAURANT_API;
    String token = await LoginService().getToken();

    final response = await http.post(URL,body: listRestaurantRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("RESTURESPONSE" + response.body);

    if(response.statusCode == 200){
      var getAddress = ListRestaurantResponse.fromJson(json.decode(response.body)).address;
      if(ListRestaurantResponse.fromJson(json.decode(response.body)).error == "false" ) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        ListRestaurantService().setLatitude(getAddress[0].latitude);
        ListRestaurantService().setLongitude(getAddress[0].longitude);
        StoreApiResponse().save("userAddress", getAddress[0].fullAddress);
        log(getAddress[0].id.toString());
        prefs.setString("addressId", getAddress[0].id.toString());
      }

      return ListRestaurantResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }


  }
}

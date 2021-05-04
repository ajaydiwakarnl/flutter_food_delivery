import 'dart:developer';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery/ApiList.dart';
import 'ListRestaurantModel.dart';

class ListRestaurantService{

  Future <ListRestaurantResponse>ListRestaurant(ListRestaurantRequest listRestaurantRequest) async {
    String URL = ApiList.LISTRESTAURANT_API;
    String token = await LoginService().getToken();

    final response = await http.post(URL,body: listRestaurantRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });
    log("RESTURESPONSE" + response.body);
    if(response.statusCode == 200){
      return ListRestaurantResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }


  }
}

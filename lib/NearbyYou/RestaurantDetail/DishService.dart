import 'dart:convert';
import 'dart:developer';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery/ApiList.dart';
import 'package:food_delivery/NearbyYou/RestaurantDetail/DishModel.dart';

class DishService{

  Future<DishResponse> listdishes (DishRequest dishRequest) async {
    String URL = ApiList.LIST_DISHES;
    String token = await LoginService().getToken();

    final response = await http.post(URL,body: dishRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("List Dish" + response.body);

    if(response.statusCode == 200){

      return DishResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }


  Future<getOutletResponse> getOutlet (outletId) async {
    String URL = ApiList.GET_OUTLET +"/"+ outletId;
    log(URL);
    final response = await http.get(URL);

    log("Get Outlet" + response.body);

    if(response.statusCode == 200){
      return getOutletResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }
  }


  Future<CouponResponse> getCouponList (getOutletRequest outletRequest) async {
    String URL = ApiList.COUPON_LIST;
    String token = await LoginService().getToken();

    final response = await http.post(URL,body: outletRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("Coupon List" + response.body);

    if(response.statusCode == 200){
      return CouponResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }
}
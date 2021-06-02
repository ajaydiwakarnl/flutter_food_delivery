import 'dart:developer';

import 'package:food_delivery/ApiList.dart';
import 'package:food_delivery/Cart/CartModel.dart';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartService{
  Future <CartResponse>ViewCart(CartRequest cartRequest) async {
    String URL = ApiList.VIEW_CART;
    String token = await LoginService().getToken();

    final response = await http.post(URL,body: cartRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("ViewCart" + response.body);

    if(response.statusCode == 200){
      return CartResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }

  Future <UpdateCartResponse>UpdateCart(UpdateCartRequest updateCartRequest) async {
    String URL = ApiList.UPDATE_CART;
    String token = await LoginService().getToken();

    final response = await http.post(URL,body: updateCartRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("Update Cart" + response.body);

    if(response.statusCode == 200){
      return UpdateCartResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }
}
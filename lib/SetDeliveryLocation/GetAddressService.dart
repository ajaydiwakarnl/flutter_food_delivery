import 'dart:developer';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:food_delivery/SetDeliveryLocation/GetAddressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery/ApiList.dart';

class GetAddressService{

  Future <GetAddress>GetAddressList() async {
    String URL = ApiList.GET_ADDRESS_API;
    String token = await LoginService().getToken();

    final response = await http.get(URL,headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });
    log("GetAddress" + response.body);
    if(response.statusCode == 200){
      return GetAddress.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }


  }
}

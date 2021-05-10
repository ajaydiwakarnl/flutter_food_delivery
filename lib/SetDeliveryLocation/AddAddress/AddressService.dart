import 'dart:developer';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:food_delivery/SetDeliveryLocation/AddAddress/AddressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery/ApiList.dart';

class AddressService{

  Future <AddressResponse>address(AddressRequest addressRequest) async {

    String URL = ApiList.ADD_ADDRESS_API;
    String token = await LoginService().getToken();

    log(addressRequest.latitude);

    final response = await http.post(URL,body: addressRequest.toJson(),headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("AddAddress" + response.body);

    if(response.statusCode == 200){
      return AddressResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }


  }
}

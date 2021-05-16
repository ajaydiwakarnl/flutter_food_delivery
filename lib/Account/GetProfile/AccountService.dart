import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/Account/GetProfile/AccountModel.dart';
import 'package:food_delivery/ApiList.dart';
import 'package:food_delivery/Login/LoginService.dart';
import 'package:http/http.dart' as http;

class AccountService{

  Future<ProfileResponse>getProfile() async {
    String URL = ApiList.GET_PROFILE;
    String token = await LoginService().getToken();

    final response = await http.get(URL,headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer  $token',
    });

    log("Profile_response" + response.body);

    if(response.statusCode == 200){
      return ProfileResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }
}
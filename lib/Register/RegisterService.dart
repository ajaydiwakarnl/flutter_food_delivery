import 'dart:developer';
import 'package:food_delivery/Register/RegisterModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery/ApiList.dart';

class RegisterService{

  Future<RegisterResponse>CheckUser(RegisterRequest registerRequest) async {
    String URL = ApiList.USER_WITH_PASSWORD_SIGNUP;
    final response = await http.post(URL,body: registerRequest.toJson());
    log("signup" + response.body);
    if(response.statusCode == 200){
      return RegisterResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }
}
import 'package:food_delivery/OtpVerfication/OtpModel.dart';
import 'package:food_delivery/ApiList.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpService{

  Future<OtpLoginResponse> otpLogin (OtpLoginRequest otpLoginRequest) async {
    String URL = ApiList.USER_OTP_LOGIN;
    final response = await http.post(URL,body: otpLoginRequest.toJson());

    log("RESPONSE" + response.body);
    if(response.statusCode == 200){
      return OtpLoginResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }
}

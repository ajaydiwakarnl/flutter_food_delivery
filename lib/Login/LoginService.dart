import 'dart:developer';
import 'package:food_delivery/Repository/StoreApiResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'LoginModel.dart';
import 'package:food_delivery/ApiList.dart';

class LoginService{

    Future<bool> setToken(String value) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.setString('token', value);
    }

    Future<String> getToken() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('token');
    }


    Future<LoginResponse>login(LoginRequest loginRequest) async {
        String URL = ApiList.LOGIN_API;
        final response = await http.post(URL,body: loginRequest.toJson());

        log("RESPONSE" + response.body);

        if(response.statusCode == 200){
            var token = LoginResponse.fromJson(json.decode(response.body)).accessToken;
            var user = LoginResponse.fromJson(json.decode(response.body)).Userdetails;
            LoginService().setToken(token);
            StoreApiResponse().save("userName", user.userName);
            StoreApiResponse().save("userEmail", user.email);
            StoreApiResponse().save("userMobile", user.mobileNumber);
            return LoginResponse.fromJson(json.decode(response.body));
        }else{
           throw Exception('something went wrong');
        }

    }
}
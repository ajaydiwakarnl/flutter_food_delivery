import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loginModel.dart';


class loginService{
    String baseUrl = "http://35.155.69.42/foodapp/public/api/";
    Future<LoginResponse>login(LoginRequest loginRequest) async {
        String URL = baseUrl + "userPasswordLogin";
        final response = await http.post(URL,body: loginRequest.toJson());
        if(response.statusCode == 200){
          return LoginResponse.fromJson(json.decode(response.body));
        }else{
           throw Exception('something went wrong');
        }

    }
}
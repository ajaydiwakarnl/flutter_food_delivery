import 'dart:developer';
import 'package:food_delivery/CheckUserExist/CheckUserExistModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:food_delivery/ApiList.dart';

class CheckUserExistService{

  Future<CheckUserExistResponse>CheckUser( CheckUserExistRequest checkUserExistRequest) async {
    String URL = ApiList.CHECK_USER_EXIST;
    final response = await http.post(URL,body: checkUserExistRequest.toJson());
    log("checkUserExistRequest" + response.body);
    if(response.statusCode == 200){
      return CheckUserExistResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('something went wrong');
    }

  }
}
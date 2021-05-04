import 'package:shared_preferences/shared_preferences.dart';
class LoginRequest{
  String mobileNumber;
  String countryCode;
  String udId;
  String password;

  LoginRequest({
      this.mobileNumber,
      this.countryCode,
      this.udId,
      this.password,
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'mobileNumber' : mobileNumber,
      'countryCode'  : countryCode,
      'udId'         : udId,
      'password'     : password
    };
    return map;
  }
}

class LoginResponse{
  final String error;
  final String errorMessage;
  UserDetails Userdetails;
  final String accessToken;
  final String isStripeAccountCreated;
  final String wallet;

  LoginResponse( { this.error, this.errorMessage, this.Userdetails, this.accessToken,this.isStripeAccountCreated,this.wallet });
  factory LoginResponse.fromJson(Map<String,dynamic> json){

    if( json['error'] == "false"){
      return LoginResponse(
        error : json['error'],
        errorMessage : json['errorMessage'].toString() ,
        Userdetails :  UserDetails.fromJson(json['Userdetails']),
        accessToken : json['accessToken'].toString(),
        isStripeAccountCreated : json['isStripeAccountCreated'].toString(),
        wallet : json['wallet'].toString(),
      );
    }else{
      return LoginResponse(
        error : json['error'],
        errorMessage : json['errorMessage'].toString() ,
        accessToken : json['accessToken'].toString(),
      );
    }

  }
}

class UserDetails {
   final int id;
   final String userName;
   final String email;
   final String mobileNumber;
   final String countryCode;
   final String encrptedPassword;
   final String image;
   final String otpNumber;
   final String deviceToken;
   final String os;
   final String udId;
   final String loginType;
   final String facebookToken;
   final String googleToken;
   final String socialToken;
   final String otp;
   final String status;
   final int CurrentAddressId;
   final String latitude;
   final String longitude;
   final String refferalCode;
   final String stripeCustomerId;
   final String created_at;
   final String updated_at;
   final String socketId;
   final int isBlocked;
   final String appleToken;
   final int isdelete;

   UserDetails( { this.id, this.userName, this.email, this.mobileNumber, this.countryCode, this.encrptedPassword, this.image, this.otpNumber, this.deviceToken, this.os,
      this.udId, this.loginType, this.facebookToken, this.googleToken, this.socialToken, this.otp, this.status, this.CurrentAddressId, this.latitude, this.longitude, this.refferalCode,
      this.stripeCustomerId, this.created_at, this.updated_at, this.socketId,
      this.isBlocked, this.appleToken, this.isdelete });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id : json["id"] ,
      userName : json['userName'] ,
      email : json['email'] ,
      mobileNumber : json['mobileNumber'],
      countryCode : json['countryCode'],
      encrptedPassword : json['encrptedPassword'],
      image : json['image'],
      otpNumber : json['otpNumber'] ,
      deviceToken : json['deviceToken'],
      os : json['os'],
      udId : json['udId'],
      loginType : json['loginType'] ,
      facebookToken : json['facebookToken'],
      googleToken : json['googleToken'],
      socialToken : json['socialToken'],
      otp : json['otp'] ,
      status : json['status'] ,
      CurrentAddressId : json['CurrentAddressId'],
      latitude : json['latitude'],
      longitude : json['longitude'] ,
      refferalCode : json['refferalCode'] ,
      stripeCustomerId : json['stripeCustomerId'] ,
      created_at : json['created_at'] ,
      updated_at : json['updated_at'] ,
      socketId : json['socketId'],
      isBlocked : json['isBlocked'] ,
      appleToken : json['appleToken'],
      isdelete : json['isdelete'],
    );
  }



}

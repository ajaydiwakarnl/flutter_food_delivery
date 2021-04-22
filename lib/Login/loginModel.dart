
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
  final String Userdetails;
  final String accessToken;

  LoginResponse( { this.error, this.errorMessage, this.Userdetails, this.accessToken });
  factory LoginResponse.fromJson( Map<String,dynamic> json){
    return LoginResponse(
      error         : json['error']         ? json['error'] :"",
      errorMessage  : json['errorMessage']  ? json['errorMessage'] :"",
      Userdetails   : json['Userdetails']   ? json['Userdetails'] :"",
      accessToken   : json['accessToken']   ? json['accessToken'] :"",
    );
  }

}

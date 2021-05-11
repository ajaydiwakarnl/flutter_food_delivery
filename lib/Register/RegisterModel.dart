class RegisterRequest{
  String userName;
  String mobileNumber;
  String countryCode;
  String email;
  String password;
  String otpNumber;
  String udId;

  RegisterRequest( { this.userName, this.mobileNumber, this.countryCode,this.email, this.password, this.otpNumber, this.udId });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'userName'     : userName,
      'mobileNumber' : mobileNumber,
      'countryCode'  : countryCode,
      'email'        : email,
      'password'     : password,
      'otpNumber'     : otpNumber,
      'udId'         : udId,

    };
    return map;
  }
}

class RegisterResponse {
  String error;
  String errorMessage;
  String wallet;
  String token;
  UserDetails userDetails;
  String isStripeAccountCreated;

  RegisterResponse( {
    this.error,
    this.errorMessage,
    this.wallet,
    this.token,
    this.userDetails,
    this.isStripeAccountCreated,
  });
  factory RegisterResponse.fromJson(Map<String,dynamic> json){

    if( json['error'] == "false"){

      return RegisterResponse(
        error: json["error"],
        errorMessage: json["errorMessage"],
        wallet: json["wallet"],
        token: json["token"],
        userDetails: UserDetails.fromJson(json["userDetails"]),
        isStripeAccountCreated: json["isStripeAccountCreated"],
      );

    }else{

      return RegisterResponse(
        error : json['error'],
        errorMessage : json['errorMessage'].toString() ,
      );
    }

  }
}

class UserDetails {
  UserDetails({
    this.id,
    this.userName,
    this.email,
    this.mobileNumber,
    this.countryCode,
    this.status,
    this.deviceToken,
    this.os,
    this.stripeCustomerId,
    this.latitude,
    this.longitude,
    this.isBlocked,
    this.isdelete,
  });

  int id;
  String userName;
  String email;
  String mobileNumber;
  String countryCode;
  dynamic status;
  dynamic deviceToken;
  dynamic os;
  String stripeCustomerId;
  dynamic latitude;
  dynamic longitude;
  int isBlocked;
  int isdelete;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    countryCode: json["countryCode"],
    status: json["status"],
    deviceToken: json["deviceToken"],
    os: json["os"],
    stripeCustomerId: json["stripeCustomerId"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isBlocked: json["isBlocked"],
    isdelete: json["isdelete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email": email,
    "mobileNumber": mobileNumber,
    "countryCode": countryCode,
    "status": status,
    "deviceToken": deviceToken,
    "os": os,
    "stripeCustomerId": stripeCustomerId,
    "latitude": latitude,
    "longitude": longitude,
    "isBlocked": isBlocked,
    "isdelete": isdelete,
  };
}

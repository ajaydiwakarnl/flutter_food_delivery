class ProfileResponse {
  ProfileResponse({
    this.error,
    this.errorMessage,
    this.usersDetails,
  });

  String error;
  String errorMessage;
  UsersDetails usersDetails;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    error: json["error"],
    errorMessage: json["errorMessage"],
    usersDetails: UsersDetails.fromJson(json["usersDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "usersDetails": usersDetails.toJson(),
  };
}

class UsersDetails {
  UsersDetails({
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
  String deviceToken;
  String os;
  String stripeCustomerId;
  dynamic latitude;
  dynamic longitude;
  int isBlocked;
  int isdelete;

  factory UsersDetails.fromJson(Map<String, dynamic> json) => UsersDetails(
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

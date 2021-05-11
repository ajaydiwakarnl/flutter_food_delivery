class OtpLoginRequest{
  String mobileNumber;
  String countryCode;
  String otpNumber;
  String udId;

  OtpLoginRequest({
    this.mobileNumber,
    this.countryCode,
    this.otpNumber,
    this.udId,
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'mobileNumber' : mobileNumber,
      'countryCode'  : countryCode,
      'udId'         : udId,
      'otpNumber'    : otpNumber
    };
    return map;
  }
}

class OtpLoginResponse {
  OtpLoginResponse({
    this.error,
    this.errorMessage,
    this.otpVerified,
    this.isNewUser,
    this.isTwilioOtp
  });

  String error;
  String errorMessage;
  String otpVerified;
  String isNewUser;
  int isTwilioOtp;

  factory OtpLoginResponse.fromJson(Map<String, dynamic> json) => OtpLoginResponse(

    error: json["error"],
    errorMessage: json["errorMessage"],
    otpVerified: json["otpVerified"] ?? "false",
    isNewUser: json["isNewUser"] ?? "false",
    isTwilioOtp: json["isTwilioOtp"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "otpVerified": otpVerified,
    "isNewUser": isNewUser,
  };
}

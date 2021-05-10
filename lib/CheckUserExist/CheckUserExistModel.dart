class CheckUserExistRequest{
  String countryCode;
  String mobileNumber;

  CheckUserExistRequest({ this.countryCode, this.mobileNumber });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'mobileNumber' : mobileNumber,
      'countryCode'  : countryCode,
    };
    return map;
  }
}

class CheckUserExistResponse {
  CheckUserExistResponse({
    this.error,
    this.errorMessage,
    this.isNewUser,
    this.otpNumber,
    this.timeDelayForOtp,
    this.isTwilioOtp,
  });

  String error;
  String errorMessage;
  String isNewUser;
  int otpNumber;
  String timeDelayForOtp;
  int isTwilioOtp;

  factory CheckUserExistResponse.fromJson(Map<String, dynamic> json) => CheckUserExistResponse(
    error: json["error"],
    errorMessage: json["errorMessage"],
    isNewUser: json["isNewUser"],
    otpNumber: json["otpNumber"],
    timeDelayForOtp: json["timeDelayForOtp"],
    isTwilioOtp : json['isTwilioOtp'],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "isNewUser": isNewUser,
    "otpNumber": otpNumber,
    "timeDelayForOtp": timeDelayForOtp,
    "isTwilioOtp" : isTwilioOtp,
  };
}

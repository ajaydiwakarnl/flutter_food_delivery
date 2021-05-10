class AddressRequest{

  String location;
  String houseFlatNo;
  String landMark;
  String latitude;
  String longitude;
  String type_1;
  String type_2;

  AddressRequest({
    this.location,
    this.houseFlatNo,
    this.landMark,
    this.latitude,
    this.longitude,
    this.type_1,
    this.type_2
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'location'  :   location,
      'houseFlatNo' : houseFlatNo,
      'landMark'    : landMark,
      'latitude'    : latitude,
      'longitude'   : longitude,
      'type'        : type_1,
      'type'        : type_2,
    };
    return map;
  }
}

class AddressResponse{
  AddressResponse({
    this.error,
    this.errorMessage,
    this.addressId,
  });

  String error;
  String errorMessage;
  int addressId;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
    error: json["error"],
    errorMessage: json["errorMessage"],
    addressId: json["addressId"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "addressId": addressId,
  };
}
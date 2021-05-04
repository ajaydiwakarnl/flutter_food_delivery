import 'dart:convert';

GetAddress getAddressFromJson(String str) => GetAddress.fromJson(json.decode(str));

String getAddressToJson(GetAddress data) => json.encode(data.toJson());

class GetAddress {
  GetAddress({
    this.error,
    this.errorMessage,
    this.address,
  });

  String error;
  String errorMessage;
  List<Address> address;

  factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
    error: json["error"],
    errorMessage: json["errorMessage"],
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.fullAddress,
    this.id,
    this.userId,
    this.location,
    this.houseFlatNo,
    this.landMark,
    this.latitude,
    this.longitude,
    this.type,
    this.currentAddress,
  });

  String fullAddress;
  int id;
  int userId;
  String location;
  String houseFlatNo;
  String landMark;
  double latitude;
  double longitude;
  String type;
  int currentAddress;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    fullAddress: json["fullAddress"],
    id: json["id"],
    userId: json["userId"],
    location: json["location"],
    houseFlatNo: json["houseFlatNo"],
    landMark: json["landMark"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    type: json["type"],
    currentAddress: json["currentAddress"],
  );

  Map<String, dynamic> toJson() => {
    "fullAddress": fullAddress,
    "id": id,
    "userId": userId,
    "location": location,
    "houseFlatNo": houseFlatNo,
    "landMark": landMark,
    "latitude": latitude,
    "longitude": longitude,
    "type": type,
    "currentAddress": currentAddress,
  };
}

import 'dart:convert';


class ListRestaurantRequest{
  String udId;
  String latitude;
  String longitude;
  String pageNumber;

  ListRestaurantRequest({
    this.udId,
    this.latitude,
    this.longitude,
    this.pageNumber,
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'udId'       : udId,
      'latitude'   : latitude,
      'longitude'  : longitude,
      'pageNumber' : pageNumber
    };
    return map;
  }

}


class ListRestaurantResponse {
  ListRestaurantResponse({
    this.address,
    this.error,
    this.errorMessage,
    this.ratings,
    this.ratingPending,
    this.cartCount,
    this.restaurantCount,
    this.banners,
    this.totalPage,
    this.listRestaurants,
  });

  List<Address> address;
  String error;
  String errorMessage;
  List<Rating> ratings;
  String ratingPending;
  int cartCount;
  int restaurantCount;
  List<dynamic> banners;
  int totalPage;
  List<ListRestaurant> listRestaurants;

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) => ListRestaurantResponse(
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    error: json["error"],
    errorMessage: json["errorMessage"],
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    ratingPending: json["ratingPending"],
    cartCount: json["cartCount"],
    restaurantCount: json["restaurantCount"],
    banners: List<dynamic>.from(json["banners"].map((x) => x)),
    totalPage: json["totalPage"],
    listRestaurants: List<ListRestaurant>.from(json["listRestaurants"].map((x) => ListRestaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
    "error": error,
    "errorMessage": errorMessage,
    "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
    "ratingPending": ratingPending,
    "cartCount": cartCount,
    "restaurantCount": restaurantCount,
    "banners": List<dynamic>.from(banners.map((x) => x)),
    "totalPage": totalPage,
    "listRestaurants": List<dynamic>.from(listRestaurants.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.fullAddress,
    this.userId,
    this.location,
    this.houseFlatNo,
    this.landMark,
    this.latitude,
    this.longitude,
    this.type,
    this.id,
  });

  String fullAddress;
  int userId;
  String location;
  String houseFlatNo;
  String landMark;
  double latitude;
  double longitude;
  String type;
  int id;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    fullAddress: json["fullAddress"],
    userId: json["userId"],
    location: json["location"],
    houseFlatNo: json["houseFlatNo"],
    landMark: json["landMark"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fullAddress": fullAddress,
    "userId": userId,
    "location": location,
    "houseFlatNo": houseFlatNo,
    "landMark": landMark,
    "latitude": latitude,
    "longitude": longitude,
    "type": type,
    "id": id,
  };
}

class ListRestaurant {
  ListRestaurant({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.isPureVeg,
    this.costForTwo,
    this.displayCostForTwo,
    this.isExculsive,
    this.unit,
    this.couponName,
    this.couponEnabledForRestaurant,
    this.shortDescription,
    this.longDescription,
    this.cuisines,
    this.averageReview,
    this.time,
    this.displayTime,
    this.breakFromTime,
    this.breakToTime,
    this.holidays,
    this.isHoliday,
    this.outlet,
  });

  int restaurantId;
  String restaurantName;
  String restaurantImage;
  int isPureVeg;
  double costForTwo;
  String displayCostForTwo;
  dynamic isExculsive;
  String unit;
  String couponName;
  int couponEnabledForRestaurant;
  String shortDescription;
  String longDescription;
  String cuisines;
  String averageReview;
  int time;
  String displayTime;
  String breakFromTime;
  String breakToTime;
  String holidays;
  bool isHoliday;
  List<Outlet> outlet;

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
    restaurantId: json["restaurantId"],
    restaurantName: json["restaurantName"],
    restaurantImage: json["restaurantImage"],
    isPureVeg: json["isPureVeg"],
    costForTwo: json["costForTwo"].toDouble(),
    displayCostForTwo: json["displayCostForTwo"],
    isExculsive: json["isExculsive"],
    unit: json["unit"],
    couponName: json["couponName"] == null ? null : json["couponName"],
    couponEnabledForRestaurant: json["couponEnabledForRestaurant"] == null ? null : json["couponEnabledForRestaurant"],
    shortDescription: json["shortDescription"] == null ? null : json["shortDescription"],
    longDescription: json["longDescription"] == null ? null : json["longDescription"],
    cuisines: json["cuisines"],
    averageReview: json["averageReview"],
    time: json["time"],
    displayTime: json["displayTime"],
    breakFromTime: json["breakFromTime"],
    breakToTime: json["breakToTime"],
    holidays: json["holidays"],
    isHoliday: json["is_holiday"],
    outlet: List<Outlet>.from(json["outlet"].map((x) => Outlet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurantId": restaurantId,
    "restaurantName": restaurantName,
    "restaurantImage": restaurantImage,
    "isPureVeg": isPureVeg,
    "costForTwo": costForTwo,
    "displayCostForTwo": displayCostForTwo,
    "isExculsive": isExculsive,
    "unit": unit,
    "couponName": couponName == null ? null : couponName,
    "couponEnabledForRestaurant": couponEnabledForRestaurant == null ? null : couponEnabledForRestaurant,
    "shortDescription": shortDescription == null ? null : shortDescription,
    "longDescription": longDescription == null ? null : longDescription,
    "cuisines": cuisines,
    "averageReview": averageReview,
    "time": time,
    "displayTime": displayTime,
    "breakFromTime": breakFromTime,
    "breakToTime": breakToTime,
    "holidays": holidays,
    "is_holiday": isHoliday,
    "outlet": List<dynamic>.from(outlet.map((x) => x.toJson())),
  };
}

class Outlet {
  Outlet({
    this.outletId,
    this.restaurantId,
    this.outletName,
    this.isServicable,
    this.offers,
    this.averageReview,
    this.time,
    this.displayTime,
    this.cuisines,
    this.costForTwo,
    this.displayCostForTwo,
    this.totalAmount,
    this.balanceAmount,
    this.status,
    this.image,
    this.breakFromTime,
    this.breakToTime,
    this.isHoliday,
    this.holidays,
    this.couponName,
    this.shortDescription,
    this.longDescription,
    this.couponEnabledForRestaurant,
  });

  int outletId;
  int restaurantId;
  String outletName;
  int isServicable;
  List<dynamic> offers;
  String averageReview;
  int time;
  String displayTime;
  String cuisines;
  double costForTwo;
  String displayCostForTwo;
  String totalAmount;
  String balanceAmount;
  int status;
  String image;
  String breakFromTime;
  String breakToTime;
  bool isHoliday;
  String holidays;
  String couponName;
  String shortDescription;
  String longDescription;
  dynamic couponEnabledForRestaurant;

  factory Outlet.fromJson(Map<String, dynamic> json) => Outlet(
    outletId: json["outletId"],
    restaurantId: json["restaurantId"],
    outletName: json["outletName"],
    isServicable: json["isServicable"],
    offers: List<dynamic>.from(json["offers"].map((x) => x)),
    averageReview: json["averageReview"],
    time: json["time"],
    displayTime: json["displayTime"],
    cuisines: json["cuisines"],
    costForTwo: json["costForTwo"].toDouble(),
    displayCostForTwo: json["displayCostForTwo"],
    totalAmount: json["totalAmount"],
    balanceAmount: json["balanceAmount"],
    status: json["status"],
    image: json["image"],
    breakFromTime: json["breakFromTime"],
    breakToTime: json["breakToTime"],
    isHoliday: json["is_holiday"],
    holidays: json["holidays"],
    couponName: json["couponName"] == null ? null : json["couponName"],
    shortDescription: json["shortDescription"] == null ? null : json["shortDescription"],
    longDescription: json["longDescription"] == null ? null : json["longDescription"],
    couponEnabledForRestaurant: json["couponEnabledForRestaurant"],
  );

  Map<String, dynamic> toJson() => {
    "outletId": outletId,
    "restaurantId": restaurantId,
    "outletName": outletName,
    "isServicable": isServicable,
    "offers": List<dynamic>.from(offers.map((x) => x)),
    "averageReview": averageReview,
    "time": time,
    "displayTime": displayTime,
    "cuisines": cuisines,
    "costForTwo": costForTwo,
    "displayCostForTwo": displayCostForTwo,
    "totalAmount": totalAmount,
    "balanceAmount": balanceAmount,
    "status": status,
    "image": image,
    "breakFromTime": breakFromTime,
    "breakToTime": breakToTime,
    "is_holiday": isHoliday,
    "holidays": holidays,
    "couponName": couponName == null ? null : couponName,
    "shortDescription": shortDescription == null ? null : shortDescription,
    "longDescription": longDescription == null ? null : longDescription,
    "couponEnabledForRestaurant": couponEnabledForRestaurant,
  };
}

class Rating {
  Rating({
    this.orderId,
    this.outletId,
    this.deliveryStaffId,
    this.outletName,
    this.deliverystaffName,
    this.deliveredTime,
    this.orderReferenceId,
  });

  int orderId;
  int outletId;
  int deliveryStaffId;
  String outletName;
  String deliverystaffName;
  DateTime deliveredTime;
  String orderReferenceId;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    orderId: json["orderId"],
    outletId: json["outletId"],
    deliveryStaffId: json["deliveryStaffId"],
    outletName: json["outletName"],
    deliverystaffName: json["deliverystaffName"],
    deliveredTime: DateTime.parse(json["deliveredTime"]),
    orderReferenceId: json["orderReferenceId"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "outletId": outletId,
    "deliveryStaffId": deliveryStaffId,
    "outletName": outletName,
    "deliverystaffName": deliverystaffName,
    "deliveredTime": deliveredTime.toIso8601String(),
    "orderReferenceId": orderReferenceId,
  };
}

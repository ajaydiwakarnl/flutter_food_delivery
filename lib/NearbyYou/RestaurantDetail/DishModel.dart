class DishRequest{
  String outletId;
  DishRequest( { this.outletId });
  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'outletId' : outletId,
    };
    return map;
  }

}

class DishResponse {
  DishResponse({
    this.error,
    this.errorMessage,
    this.dishes,
  });

  String error;
  String errorMessage;
  List<Dish> dishes;


  factory DishResponse.fromJson(Map<String,dynamic> json){

    if( json['error'] == "false"){
      return DishResponse(
        error: json["error"],
        errorMessage: json["errorMessage"],
        dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      );
    }else{
      return DishResponse(
        error : json['error'],
        errorMessage : json['errorMessage'].toString(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
  };
}

class Dish {
  Dish({
    this.categoryId,
    this.categoryName,
    this.isRecommended,
    this.isHavingSubCategory,
    this.categoryValues,
  });

  int categoryId;
  String categoryName;
  int isRecommended;
  int isHavingSubCategory;
  List<CategoryValue> categoryValues;

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    isRecommended: json["isRecommended"],
    isHavingSubCategory: json["isHavingSubCategory"],
    categoryValues: List<CategoryValue>.from(json["categoryValues"].map((x) => CategoryValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "isRecommended": isRecommended,
    "isHavingSubCategory": isHavingSubCategory,
    "categoryValues": List<dynamic>.from(categoryValues.map((x) => x.toJson())),
  };
}

class CategoryValue {
  CategoryValue({
    this.categoryId,
    this.dishId,
    this.dishName,
    this.price,
    this.displayPrice,
    this.slashedPrice,
    this.dishImage,
    this.isVeg,
    this.availableFrom,
    this.availableTo,
    this.availableFromTime,
    this.availableToTime,
    this.categoryavailableFromTime,
    this.categoryavailableToTime,
    this.isRecommended,
    this.isAvailable,
    this.dishCustomisation,
    this.isCustomizable,
    this.description,
    this.Counter
  });

  dynamic categoryId;
  int dishId;
  String dishName;
  int price;
  String displayPrice;
  int slashedPrice;
  String dishImage;
  int isVeg;
  int availableFrom;
  int availableTo;
  String availableFromTime;
  String availableToTime;
  CategoryavailableFromTime categoryavailableFromTime;
  CategoryavailableToTime categoryavailableToTime;
  int isRecommended;
  String isAvailable;
  List<DishCustomisation> dishCustomisation;
  int isCustomizable;
  String description;
  int Counter ;

  factory CategoryValue.fromJson(Map<String, dynamic> json) => CategoryValue(
    categoryId: json["categoryId"],
    dishId: json["dishId"],
    dishName: json["dishName"],
    price: json["price"],
    displayPrice: json["displayPrice"],
    slashedPrice: json["slashedPrice"],
    dishImage: json["dishImage"] == null ? null : json["dishImage"],
    isVeg: json["isVeg"],
    availableFrom: json["availableFrom"],
    availableTo: json["availableTo"],
    availableFromTime: json["availableFromTime"],
    availableToTime: json["availableToTime"],
    categoryavailableFromTime: categoryavailableFromTimeValues.map[json["categoryavailableFromTime"]],
    categoryavailableToTime: categoryavailableToTimeValues.map[json["categoryavailableToTime"]],
    isRecommended: json["isRecommended"] == null ? null : json["isRecommended"],
    isAvailable: json["isAvailable"],
    dishCustomisation: List<DishCustomisation>.from(json["dishCustomisation"].map((x) => DishCustomisation.fromJson(x))),
    isCustomizable: json["isCustomizable"],
    description: json["description"] == null ? null : json["description"],
    Counter: 0,
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "dishId": dishId,
    "dishName": dishName,
    "price": price,
    "displayPrice": displayPrice,
    "slashedPrice": slashedPrice,
    "dishImage": dishImage == null ? null : dishImage,
    "isVeg": isVeg,
    "availableFrom": availableFrom,
    "availableTo": availableTo,
    "availableFromTime": availableFromTime,
    "availableToTime": availableToTime,
    "categoryavailableFromTime": categoryavailableFromTimeValues.reverse[categoryavailableFromTime],
    "categoryavailableToTime": categoryavailableToTimeValues.reverse[categoryavailableToTime],
    "isRecommended": isRecommended == null ? null : isRecommended,
    "isAvailable": isAvailable,
    "dishCustomisation": List<dynamic>.from(dishCustomisation.map((x) => x.toJson())),
    "isCustomizable": isCustomizable,
    "description": description == null ? null : description,
    "Counter": Counter,
  };
}

enum CategoryavailableFromTime { THE_0000, THE_0001 }

final categoryavailableFromTimeValues = EnumValues({
  "00:00": CategoryavailableFromTime.THE_0000,
  "00:01": CategoryavailableFromTime.THE_0001
});

enum CategoryavailableToTime { THE_2358, THE_2359 }

final categoryavailableToTimeValues = EnumValues({
  "23:58": CategoryavailableToTime.THE_2358,
  "23:59": CategoryavailableToTime.THE_2359
});

class DishCustomisation {
  DishCustomisation({
    this.customizableId,
    this.customizableName,
    this.customizableType,
    this.customizableMaxSelect,
    this.customizableMinxSelect,
    this.customizableDishItems,
    this.currentSelectedCount,
  });

  int customizableId;
  CustomizableName customizableName;
  CustomizableType customizableType;
  int customizableMaxSelect;
  int customizableMinxSelect;
  List<CustomizableDishItem> customizableDishItems;
  int currentSelectedCount;

  factory DishCustomisation.fromJson(Map<String, dynamic> json) => DishCustomisation(
    customizableId: json["customizableId"],
    customizableName: customizableNameValues.map[json["customizableName"]],
    customizableType: customizableTypeValues.map[json["customizableType"]],
    customizableMaxSelect: json["customizableMaxSelect"],
    customizableMinxSelect: json["customizableMinxSelect"],
    customizableDishItems: List<CustomizableDishItem>.from(json["customizableDishItems"].map((x) => CustomizableDishItem.fromJson(x))),
    currentSelectedCount: json["currentSelectedCount"],
  );

  Map<String, dynamic> toJson() => {
    "customizableId": customizableId,
    "customizableName": customizableNameValues.reverse[customizableName],
    "customizableType": customizableTypeValues.reverse[customizableType],
    "customizableMaxSelect": customizableMaxSelect,
    "customizableMinxSelect": customizableMinxSelect,
    "customizableDishItems": List<dynamic>.from(customizableDishItems.map((x) => x.toJson())),
    "currentSelectedCount": currentSelectedCount,
  };
}

class CustomizableDishItem {
  CustomizableDishItem({
    this.elementId,
    this.elementName,
    this.price,
    this.displayPrice,
    this.customisationCategoryId,
    this.isSelected,
    this.isVeg,
  });

  int elementId;
  String elementName;
  int price;
  String displayPrice;
  int customisationCategoryId;
  int isSelected;
  int isVeg;

  factory CustomizableDishItem.fromJson(Map<String, dynamic> json) => CustomizableDishItem(
    elementId: json["elementId"],
    elementName: json["elementName"],
    price: json["Price"],
    displayPrice: json["displayPrice"],
    customisationCategoryId: json["customisationCategoryId"],
    isSelected: json["isSelected"],
    isVeg: json["isVeg"],
  );

  Map<String, dynamic> toJson() => {
    "elementId": elementId,
    "elementName": elementName,
    "Price": price,
    "displayPrice": displayPrice,
    "customisationCategoryId": customisationCategoryId,
    "isSelected": isSelected,
    "isVeg": isVeg,
  };
}

enum CustomizableName { TOPPING_SAUCES, GARNISH, NORTH_INDIAN }

final customizableNameValues = EnumValues({
  "Garnish": CustomizableName.GARNISH,
  "North Indian": CustomizableName.NORTH_INDIAN,
  "Topping Sauces": CustomizableName.TOPPING_SAUCES
});

enum CustomizableType { MULTIPLE }

final customizableTypeValues = EnumValues({
  "multiple": CustomizableType.MULTIPLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class getOutletRequest{
  String outletId;
  getOutletRequest( { this.outletId } );
  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'outletId' : outletId,
    };
    return map;
  }
}

class getOutletResponse {
  getOutletResponse({
    this.error,
    this.errorMessage,
    this.outlets,
    this.currency,
    this.orders,
  });

  String error;
  String errorMessage;
  Outlets outlets;
  String currency;
  List<Order> orders;

  factory getOutletResponse.fromJson(Map<String, dynamic> json) => getOutletResponse(
    error: json["error"],
    errorMessage: json["errorMessage"],
    outlets: Outlets.fromJson(json["outlets"]),
    currency: json["currency"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "outlets": outlets.toJson(),
    "currency": currency,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    this.orderId,
    this.orderReferenceId,
    this.netAmount,
    this.orderStatus,
    this.orderPlaceTime,
    this.confirmedTime,
    this.mobileNumber,
    this.email,
    this.updatedAt,
  });

  int orderId;
  String orderReferenceId;
  double netAmount;
  String orderStatus;
  DateTime orderPlaceTime;
  DateTime confirmedTime;
  String mobileNumber;
  String email;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json["orderId"],
    orderReferenceId: json["orderReferenceId"],
    netAmount: json["netAmount"].toDouble(),
    orderStatus: json["orderStatus"],
    orderPlaceTime: DateTime.parse(json["orderPlaceTime"]),
    confirmedTime: json["confirmedTime"] == null ? null : DateTime.parse(json["confirmedTime"]),
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderReferenceId": orderReferenceId,
    "netAmount": netAmount,
    "orderStatus": orderStatus,
    "orderPlaceTime": orderPlaceTime.toIso8601String(),
    "confirmedTime": confirmedTime == null ? null : confirmedTime.toIso8601String(),
    "mobileNumber": mobileNumber,
    "email": email,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Outlets {
  Outlets({
    this.outletId,
    this.outletName,
    this.image,
    this.restaurantId,
    this.email,
    this.isPureVeg,
    this.showFromTime,
    this.showToTime,
    this.convenienceFee,
    this.costForTwo,
    this.addressLineOne,
    this.addressLineTwo,
    this.street,
    this.area,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.latitude,
    this.longitude,
    this.contactNumber,
    this.status,
    this.preparationTime,
    this.commission,
    this.totalAmount,
    this.balanceAmount,
    this.averageRating,
    this.isBlocked,
    this.holiday,
    this.breakFromTime,
    this.breakToTime,
  });

  int outletId;
  String outletName;
  String image;
  int restaurantId;
  String email;
  int isPureVeg;
  String showFromTime;
  String showToTime;
  int convenienceFee;
  int costForTwo;
  String addressLineOne;
  String addressLineTwo;
  String street;
  String area;
  String city;
  String state;
  dynamic country;
  dynamic zipcode;
  String latitude;
  String longitude;
  String contactNumber;
  int status;
  int preparationTime;
  int commission;
  String totalAmount;
  String balanceAmount;
  int averageRating;
  int isBlocked;
  String holiday;
  String breakFromTime;
  String breakToTime;

  factory Outlets.fromJson(Map<String, dynamic> json) => Outlets(
    outletId: json["outletId"],
    outletName: json["outletName"],
    image: json["image"],
    restaurantId: json["restaurantId"],
    email: json["email"],
    isPureVeg: json["isPureVeg"],
    showFromTime: json["showFromTime"],
    showToTime: json["showToTime"],
    convenienceFee: json["convenienceFee"],
    costForTwo: json["costForTwo"],
    addressLineOne: json["addressLineOne"],
    addressLineTwo: json["addressLineTwo"],
    street: json["street"],
    area: json["area"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zipcode: json["zipcode"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    contactNumber: json["contactNumber"],
    status: json["status"],
    preparationTime: json["preparationTime"],
    commission: json["commission"],
    totalAmount: json["totalAmount"],
    balanceAmount: json["balanceAmount"],
    averageRating: json["averageRating"],
    isBlocked: json["isBlocked"],
    holiday: json["holiday"],
    breakFromTime: json["breakFromTime"],
    breakToTime: json["breakToTime"],
  );

  Map<String, dynamic> toJson() => {
    "outletId": outletId,
    "outletName": outletName,
    "image": image,
    "restaurantId": restaurantId,
    "email": email,
    "isPureVeg": isPureVeg,
    "showFromTime": showFromTime,
    "showToTime": showToTime,
    "convenienceFee": convenienceFee,
    "costForTwo": costForTwo,
    "addressLineOne": addressLineOne,
    "addressLineTwo": addressLineTwo,
    "street": street,
    "area": area,
    "city": city,
    "state": state,
    "country": country,
    "zipcode": zipcode,
    "latitude": latitude,
    "longitude": longitude,
    "contactNumber": contactNumber,
    "status": status,
    "preparationTime": preparationTime,
    "commission": commission,
    "totalAmount": totalAmount,
    "balanceAmount": balanceAmount,
    "averageRating": averageRating,
    "isBlocked": isBlocked,
    "holiday": holiday,
    "breakFromTime": breakFromTime,
    "breakToTime": breakToTime,
  };
}

class CouponResponse {
  CouponResponse({
    this.error,
    this.errorMessage,
    this.couponDetails,
  });

  String error;
  String errorMessage;
  List<CouponDetail> couponDetails;

  factory CouponResponse.fromJson(Map<String, dynamic> json){
    return CouponResponse(
      error: json["error"],
      errorMessage: json["error_message"],
      couponDetails: List<CouponDetail>.from(json["couponDetails"].map((x) => CouponDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "error_message": errorMessage,
    "couponDetails": List<dynamic>.from(couponDetails.map((x) => x.toJson())),
  };
}

class CouponDetail {
  CouponDetail({
    this.couponId,
    this.couponDescription,
    this.couponcode,
    this.coupontype,
    this.coupondiscount,
    this.couponRules,
  });

  int couponId;
  String couponDescription;
  dynamic couponcode;
  dynamic coupontype;
  dynamic coupondiscount;
  List<dynamic> couponRules;

  factory CouponDetail.fromJson(Map<String, dynamic> json) => CouponDetail(
    couponId: json["couponId"],
    couponDescription: json["couponDescription"],
    couponcode: json["couponcode"],
    coupontype: json["coupontype"],
    coupondiscount: json["coupondiscount"],
    couponRules: List<dynamic>.from(json["couponRules"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "couponId": couponId,
    "couponDescription": couponDescription,
    "couponcode": couponcode,
    "coupontype": coupontype,
    "coupondiscount": coupondiscount,
    "couponRules": List<dynamic>.from(couponRules.map((x) => x)),
  };
}


class AddToCartRequest{

  String outletId;
  String udId;
  String dishes;


  AddToCartRequest( { this.outletId, this.udId, this.dishes });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'outletId' : outletId,
      'udId'     : udId,
      'dishes'   : dishes,
    };
    return map;
  }

}

class AddToCartResponse {

  AddToCartResponse({
    this.error,
    this.errorMessage,
  });

  String error;
  String errorMessage;

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => AddToCartResponse(
    error: json["error"],
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
  };
}


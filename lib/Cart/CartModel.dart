class CartRequest{

  String udId;
  String addressId;

  CartRequest({
    this.udId,
    this.addressId,
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'udId'       : udId,
      'addressId'  : addressId
    };
    return map;
  }
}


class CartResponse {
  CartResponse({
    this.error,
    this.errorMessage,
    this.couponStatus,
    this.dishes,
  });

  String error;
  String errorMessage;
  bool couponStatus;
  Dishes dishes;

  factory CartResponse.fromJson(Map<String, dynamic> json){
    if( json['error'] == "false"){
      return CartResponse(
        error: json["error"],
        errorMessage: json["errorMessage"],
        couponStatus: json["couponStatus"],
        dishes: Dishes.fromJson(json["dishes"]),);
    }else{
      return CartResponse(error: json["error"], errorMessage: json["errorMessage"]);
    }
  }


  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "couponStatus": couponStatus,
    "dishes": dishes.toJson(),
  };
}

class Dishes {
  Dishes({
    this.outletDetails,
    this.dishes,
    this.billTotals,
    this.isTwoMany,
    this.toMany,
    this.isAddress,
    this.address,
  });

  OutletDetails outletDetails;
  List<CartDish> dishes;
  List<BillTotal> billTotals;
  bool isTwoMany;
  ToMany toMany;
  bool isAddress;
  Address address;

  factory Dishes.fromJson(Map<String, dynamic> json) => Dishes(
    outletDetails: OutletDetails.fromJson(json["outletDetails"]),
    dishes: List<CartDish>.from(json["dishes"].map((x) => CartDish.fromJson(x))),
    billTotals: List<BillTotal>.from(json["billTotals"].map((x) => BillTotal.fromJson(x))),
    isTwoMany: json["isTwoMany"],
    toMany: ToMany.fromJson(json["toMany"]),
    isAddress: json["isAddress"],
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "outletDetails": outletDetails.toJson(),
    "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
    "billTotals": List<dynamic>.from(billTotals.map((x) => x.toJson())),
    "isTwoMany": isTwoMany,
    "toMany": toMany.toJson(),
    "isAddress": isAddress,
    "address": address.toJson(),
  };
}

class Address {
  Address({
    this.address,
    this.time,
    this.displayTime,
    this.name,
    this.addressId,
    this.unsaved,
  });

  String address;
  String time;
  String displayTime;
  String name;
  int addressId;
  int unsaved;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    time: json["time"],
    displayTime: json["displayTime"],
    name: json["name"],
    addressId: json["addressId"],
    unsaved: json["unsaved"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "time": time,
    "displayTime": displayTime,
    "name": name,
    "addressId": addressId,
    "unsaved": unsaved,
  };
}

class BillTotal {
  BillTotal({
    this.displayKey,
    this.displayValue,
    this.itemTotal,
    this.percentage,
    this.orginalDeiverycharge,
    this.id,
    this.status,
    this.netAmount,
  });

  String displayKey;
  String displayValue;
  int itemTotal;
  dynamic percentage;
  String orginalDeiverycharge;
  int id;
  int status;
  String netAmount;

  factory BillTotal.fromJson(Map<String, dynamic> json) => BillTotal(
    displayKey: json["displayKey"],
    displayValue: json["displayValue"],
    itemTotal: json["itemTotal"] == null ? null : json["itemTotal"],
    percentage: json["percentage"],
    orginalDeiverycharge: json["orginal_deiverycharge"] == null ? null : json["orginal_deiverycharge"],
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    netAmount: json["netAmount"] == null ? null : json["netAmount"],
  );

  Map<String, dynamic> toJson() => {
    "displayKey": displayKey,
    "displayValue": displayValue,
    "itemTotal": itemTotal == null ? null : itemTotal,
    "percentage": percentage,
    "orginal_deiverycharge": orginalDeiverycharge == null ? null : orginalDeiverycharge,
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "netAmount": netAmount == null ? null : netAmount,
  };
}

class CartDish {
  CartDish({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.isVeg,
    this.description,
    this.isAvailable,
    this.dishCustomisation,
    this.dishQuantity,
    this.cartId,
    this.uuId,
    this.dishTotal,
    this.originalDishTotal,
    this.dishPriceTotal,
    this.displayDishTotal,
    this.slashedPrice,
    this.isCustomizable,
    this.Counter
  });

  int dishId;
  String dishName;
  int dishPrice;
  int isVeg;
  String description;
  bool isAvailable;
  List<dynamic> dishCustomisation;
  int dishQuantity;
  int cartId;
  String uuId;
  int dishTotal;
  int originalDishTotal;
  int dishPriceTotal;
  String displayDishTotal;
  int slashedPrice;
  int isCustomizable;
  int Counter;

  factory CartDish.fromJson(Map<String, dynamic> json) => CartDish(
    dishId: json["dishId"],
    dishName: json["dishName"],
    dishPrice: json["dishPrice"],
    isVeg: json["isVeg"],
    description: json["description"],
    isAvailable: json["isAvailable"],
    dishCustomisation: List<dynamic>.from(json["dishCustomisation"].map((x) => x)),
    dishQuantity: json["dishQuantity"],
    cartId: json["cartId"],
    uuId: json["uuId"],
    dishTotal: json["dishTotal"],
    originalDishTotal: json["originalDishTotal"],
    dishPriceTotal: json["dishPriceTotal"],
    displayDishTotal: json["displayDishTotal"],
    slashedPrice: json["slashedPrice"],
    isCustomizable: json["isCustomizable"],
    Counter: json["Counter"],
  );

  Map<String, dynamic> toJson() => {
    "dishId": dishId,
    "dishName": dishName,
    "dishPrice": dishPrice,
    "isVeg": isVeg,
    "description": description,
    "isAvailable": isAvailable,
    "dishCustomisation": List<dynamic>.from(dishCustomisation.map((x) => x)),
    "dishQuantity": dishQuantity,
    "cartId": cartId,
    "uuId": uuId,
    "dishTotal": dishTotal,
    "originalDishTotal": originalDishTotal,
    "dishPriceTotal": dishPriceTotal,
    "displayDishTotal": displayDishTotal,
    "slashedPrice": slashedPrice,
    "isCustomizable": isCustomizable,
  };
}

class OutletDetails {
  OutletDetails({
    this.outletId,
    this.outletName,
    this.outletImage,
    this.outletArea,
    this.latitude,
    this.longitude,
    this.deliveryCharges,
    this.restaurantCommission,
    this.serviceCommission,
    this.restaurantId,
    this.type,
    this.totalAmount,
    this.convenienceFee,
    this.takeaway,
  });

  int outletId;
  String outletName;
  String outletImage;
  String outletArea;
  String latitude;
  String longitude;
  dynamic deliveryCharges;
  int restaurantCommission;
  int serviceCommission;
  int restaurantId;
  String type;
  String totalAmount;
  int convenienceFee;
  String takeaway;

  factory OutletDetails.fromJson(Map<String, dynamic> json) => OutletDetails(
    outletId: json["outletId"],
    outletName: json["outletName"],
    outletImage: json["outletImage"],
    outletArea: json["outletArea"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    deliveryCharges: json["deliveryCharges"],
    restaurantCommission: json["restaurantCommission"],
    serviceCommission: json["serviceCommission"],
    restaurantId: json["restaurantId"],
    type: json["type"],
    totalAmount: json["totalAmount"],
    convenienceFee: json["convenienceFee"],
    takeaway: json["takeaway"],
  );

  Map<String, dynamic> toJson() => {
    "outletId": outletId,
    "outletName": outletName,
    "outletImage": outletImage,
    "outletArea": outletArea,
    "latitude": latitude,
    "longitude": longitude,
    "deliveryCharges": deliveryCharges,
    "restaurantCommission": restaurantCommission,
    "serviceCommission": serviceCommission,
    "restaurantId": restaurantId,
    "type": type,
    "totalAmount": totalAmount,
    "convenienceFee": convenienceFee,
    "takeaway": takeaway,
  };
}

class ToMany {
  ToMany();
  factory ToMany.fromJson(Map<String, dynamic> json) => ToMany(
  );
  Map<String, dynamic> toJson() => {
  };
}


class UpdateCartRequest{

  String udId;
  String cartId;
  String outletId;
  String quantity;

  UpdateCartRequest({
    this.udId,
    this.cartId,
    this.outletId,
    this.quantity,
  });

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {
      'cartId'     : cartId,
      'udId'       : udId,
      'outletId'   : outletId,
      'quantity'   : quantity
    };
    return map;
  }
}

class UpdateCartResponse{
  UpdateCartResponse({
    this.error,
    this.errorMessage,
  });

  String error;
  String errorMessage;

  factory UpdateCartResponse.fromJson(Map<String, dynamic> json) => UpdateCartResponse(
    error: json["error"],
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
  };
}


class ApiList {
  static const String apibaseUrl = "http://44.242.96.167/foodapp/public/api/";
  static const String adminbaseUrl = "http://44.242.96.167/foodapp/public/admin/";

  //API RELATE API ROUTE
  static const String CHECK_USER_EXIST                  = apibaseUrl + "CheckAvailability";
  static const String USER_OTP_LOGIN                    = apibaseUrl + "userOtpLogin";
  static const String USER_WITH_PASSWORD_SIGNUP         = apibaseUrl + "userWithPasswordSignup";
  static const String LOGIN_API                         = apibaseUrl + "userPasswordLogin";
  static const String LISTRESTAURANT_API                = apibaseUrl + "listRestaurant";
  static const String GET_ADDRESS_API                   = apibaseUrl + "getAddress";
  static const String ADD_ADDRESS_API                   = apibaseUrl + "addAddress";
  static const String GET_PROFILE                       = apibaseUrl + "getProfile";
  static const String LIST_DISHES                       = apibaseUrl + "listDishes";
  static const String COUPON_LIST                        = apibaseUrl + "couponList";

  //ADMIN RELATE API ROUTE
  static const String GET_OUTLET                       = adminbaseUrl + "getOutlet";
}

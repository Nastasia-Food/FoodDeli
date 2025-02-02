// ignore_for_file: file_names

class APIList {
  static String? licenseCode = "b6d68vy2-m7g5-20r0-5275-h103w73453q120";
  static String? baseUrl = "https://demo.foodking.dev";
  static String? login = "${baseUrl!}/api/auth/login";
  static String? profile = "${baseUrl!}/api/profile";
  static String? changeProfileImage = "${baseUrl!}/api/profile/change-image";
  static String? configuration = "${baseUrl!}/api/frontend/setting";
  static String? countryInfo = "${baseUrl!}/api/frontend/country-code/show/";
  static String? changePassword = "${baseUrl!}/api/profile/change-password";
  static String? branch = "${baseUrl!}/api/frontend/branch";
  static String? token = "${baseUrl!}/api/frontend/device-token/mobile";
  static String? orderList = "${baseUrl!}/api/frontend/delivery-boy-order";
  static String? orderDetails =
      "${baseUrl!}/api/frontend/delivery-boy-order/show/";
  static String? orderCount =
      "${baseUrl!}/api/frontend/delivery-boy-order/count";
  static String? changeOrderStatus =
      "${baseUrl!}/api/frontend/delivery-boy-order/change-status/";
  static String? refreshToken = "${baseUrl!}/api/refresh-token?token=";
  static String? pages = "${baseUrl!}/api/frontend/page";
  static String? language = "${baseUrl!}/api/frontend/language";
}

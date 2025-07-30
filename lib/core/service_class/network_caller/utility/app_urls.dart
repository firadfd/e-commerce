class AppUrls {
  static const String baseUrl = 'https://api.eparko.ae/api/v1';
  // static const String baseUrl = 'http://10.0.20.15:5004/api/v1';

  static const String registerUrl = '$baseUrl/users/create';

  static const String loginUrl = '$baseUrl/auth/login';
  static const String optionalLogin = '$baseUrl/auth/optional-login';
  static const String send_otp = '$baseUrl/auth/send-otp';
  static const String verify_otp = '$baseUrl/auth/verify-otp';
  static const String profile = '$baseUrl/auth/profile';
  static const String saveCard = '$baseUrl/subscription/save-card';
  static const String familyToken = '$baseUrl/subscription/get-family-plan';
  static const String userLogout = '$baseUrl/auth/logout';
  static const String userDelete = '$baseUrl/auth/account-delete';
  static const String updateLocation = '$baseUrl/auth/update/user-location';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String userAutoPayment = '$baseUrl/auth/update/auto-payment';
  static const String updateDocument = '$baseUrl/auth/update/passenger-document';

  static const String createCar = '$baseUrl/cars/create';
  static const String myBooking = '$baseUrl/booking/get-user-booking';
  static const String availableBalance = '$baseUrl/subscription/avable-blance';
  static const String notification = '$baseUrl/notification';
  static const String deleteNotification = '$baseUrl/notification/delete-notification';
  static const String cars = '$baseUrl/cars';
  static const String subscriptionUrl = '$baseUrl/subscription/purchase-subscription';
  static const String topUpUrl = '$baseUrl/subscription/top-up-wallet';
  static const String plans = '$baseUrl/subscription/get-all-subscription-plans';
  static const String payByWallet = '$baseUrl/subscription/pay-by-wallet';
  static const String updateSmsStatus = '$baseUrl/subscription/sms-payment';
  static const String updateImage = '$baseUrl/auth/update-profile-image';
  static const String tariffList = '$baseUrl/parking-slots/tariff-list';
  static const String notificationNumber = '$baseUrl/notification/count';
  static const String notificationRead = '$baseUrl/notification/read';
  static const String cancelAutoPayment = '$baseUrl/parking-slots/auto-payment-action';
  static const String createFamilyPlan = '$baseUrl/subscription/create-family-plan';

}

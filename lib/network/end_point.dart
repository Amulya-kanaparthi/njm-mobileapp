class EndPoint {
  static const String register = "/user/register";
  static const String login = "/user/login";
  static const String verifyOTP = "/user/verify-otp";
  static const String logout = "/user/logout";
  static const String forgotPassword = "/user/forgot-password";
  static const String checkAuthentication = "/user/check-authentication";
  static const String resetPassword = "/user/reset-password";
  static const String getBooks = "/bible/books/:language";
  static const String getChapters = "/bible/:language/:book/chapters";
  static const String getVerses = "/bible/:language/:book/:chapter";
  static const String getFullBible = "/bible/full/:language/";
}

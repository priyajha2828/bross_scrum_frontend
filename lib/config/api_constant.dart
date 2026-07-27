class ApiConstant {
  ApiConstant._();

  static const String baseUrl = "http://192.168.1.86:3000/api/v1";

  static const String login = "/auth/login";
  static const String signup = "/auth/signup";
  static const String me = "/auth/me";
  static const String verifyOtp = "/auth/verify-otp";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resetPassword= "/auth/reset-password";
  static const String logout = "/auth/logout";
  static const String createorg = "/organizations/create";
  static const String getOrganization = "/organizations";
  static const String googlesignin = "/callback/google";
}
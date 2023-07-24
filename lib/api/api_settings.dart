
class ApiSettings{
  // Be sure that laptop ip is still the same when u use local server
  static const String _baseUrl = "http://192.168.0.108/";
  static const String _apiUrl = _baseUrl + "api/";

  static const String register = _apiUrl + "auth/register";
  static const String login = _apiUrl + "auth/login";
  static const String logout = _apiUrl + "auth/logout";
  static const String forgetPassword = _apiUrl + "auth/password/email";
  static const String resetForgetPassword = _apiUrl + "auth/password/reset";
  static const String resetPassword = _apiUrl + "auth/password/reset";

  static const String homeProducts = _apiUrl + "product";



}
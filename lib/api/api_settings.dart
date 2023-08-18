
class ApiSettings{
  // Be sure that laptop ip is still the same when u use local server
  // static const String _baseUrl = "http://192.168.0.105/";

  static const String _baseUrl = "https://handcraft.website/";
  static const String _apiUrl = _baseUrl + "api/";
  static const String _imageUrl = _baseUrl + "storage/";

  static getImageUrl (String image){
    return _imageUrl + image;
  }

  static const String register = _apiUrl + "auth/register";
  static const String login = _apiUrl + "auth/login";
  static const String logout = _apiUrl + "auth/logout";
  static const String forgetPassword = _apiUrl + "auth/password/email";
  static const String resetForgetPassword = _apiUrl + "auth/password/reset";  //
  static const String updateProfilePassword = _apiUrl + "user/password/update";
  static const String getProfile = _apiUrl + "profile";
  static const String updateProfile = _apiUrl + "user/profile/update";

  static const String product = _apiUrl + "product/{id}";


  static const String favorite = _apiUrl + "product/favorites"; //تحتاج تعديل
  static const String stores = _apiUrl + "store/{id}"; //تحتاج تعديل

  static const String rateProduct = _apiUrl + "rating";

  static const String commonQuestion = _apiUrl + "common-quastions";
  static const String contactUs = _apiUrl + "contact-us";




/// These for Cart history
//   static const String Upload_URI = "/uploads/";
//   static const String CART_LIST = "cart-list";
//   static const String CART_HISTORY_LIST = "cart-history-list";

}
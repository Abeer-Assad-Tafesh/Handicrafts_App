
class ApiSettings{
  // Be sure that laptop ip is still the same when u use local server
  // static const String _baseUrl = "http://192.168.0.107/";

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
  static const String updateProfile = _apiUrl + "user/update/profile";

  static const String product = _apiUrl + "product/{id}";
  static const String productImages = _apiUrl + "product_images";
  static const String updateProductImages = _apiUrl + "update-product-images";


  static const String favorite = _apiUrl + "product/favorites";
  static const String stores = _apiUrl + "store/{id}";
  static const String updateStore = _apiUrl + "update-store/{id}";

  static const String order = _apiUrl + "order/{id}";
  static const String orderItems = _apiUrl + "order_items";
  static const String updateOrderStatus = _apiUrl + "update-order/{id}";


  static const String rateProduct = _apiUrl + "make/product/rate/{id}";

  static const String whoUs = _apiUrl + "get/setting/data";
  static const String commonQuestion = _apiUrl + "common-quastions";
  static const String contactUs = _apiUrl + "contact-us";






/// These for Cart history
//   static const String Upload_URI = "/uploads/";
//   static const String CART_LIST = "cart-list";
//   static const String CART_HISTORY_LIST = "cart-history-list";

}
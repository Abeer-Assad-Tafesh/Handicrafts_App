
import 'package:handcrafts/api/models/api_base_response.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys{
  loggedIn, name, email, phoneNumber,typeUser, token ,chatMessages
}
class SharedPrefController{

  static final SharedPrefController _instance = SharedPrefController._();
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;
  UserApi? user;

  factory SharedPrefController(){
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }



  Future<void> save({required UserApi user, required String token}) async {
    this.user = user;
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setString(PrefKeys.name.toString(), user.name);
    await _sharedPreferences.setString(PrefKeys.email.toString(), user.email);
    await _sharedPreferences.setString(PrefKeys.phoneNumber.toString(), user.phoneNumber?? '');
    await _sharedPreferences.setString(PrefKeys.typeUser.toString(), user.typeUser?? '');
    await _sharedPreferences.setString(PrefKeys.token.toString(), 'Bearer '+ token);
  }

  Future<void> saveChatMessage(String message) async {
    List<String> chatMessages = _sharedPreferences.getStringList(PrefKeys.chatMessages.toString()) ?? [];
    chatMessages.add(message);
    _sharedPreferences.setStringList(PrefKeys.chatMessages.toString(), chatMessages);
  }


  bool get loggedIn => _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  String get token => _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';
  String get name => _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';
  String get email => _sharedPreferences.getString(PrefKeys.email.toString()) ?? '';
  String get phone => _sharedPreferences.getString(PrefKeys.phoneNumber.toString()) ?? '';

  List<String> get chatMessages => _sharedPreferences.getStringList(PrefKeys.chatMessages.toString()) ?? [];


  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
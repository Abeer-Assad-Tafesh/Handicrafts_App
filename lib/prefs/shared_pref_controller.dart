
import 'package:handcrafts/api/models/api_base_response.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys{
                                         // user has store
                                         // so he has userId & storeId
  loggedIn, storeExist, name, email, id, craftsmanUserId, craftsmanStoreId, phoneNumber, password, typeUser, token ,chatMessages
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
    await _sharedPreferences.setString(PrefKeys.id.toString(), user.id.toString());
    await _sharedPreferences.setString(PrefKeys.craftsmanUserId.toString(), user.id.toString()?? '');
    await _sharedPreferences.setString(PrefKeys.phoneNumber.toString(), user.phoneNumber?? '');
    await _sharedPreferences.setString(PrefKeys.typeUser.toString(), user.typeUser?? '');
    await _sharedPreferences.setString(PrefKeys.token.toString(), 'Bearer '+ token);
  }

  Future<void> updateEmail({required email}) async {
    await _sharedPreferences.setString(PrefKeys.email.toString(), email?? '');
  }

  Future<void> updatePassword({required password}) async {
    await _sharedPreferences.setString(PrefKeys.password.toString(), password?? '');
  }

  Future<void> savePassword({required password}) async {
    await _sharedPreferences.setString(PrefKeys.password.toString(), password?? '');
  }

  Future<void> storeExist({required isExist}) async {
    await _sharedPreferences.setBool(PrefKeys.storeExist.toString(), isExist);
  }

  Future<void> saveCraftsmanStoreId({required storeId}) async {
    await _sharedPreferences.setString(PrefKeys.craftsmanStoreId.toString(), storeId.toString() ?? '');
  }

    Future<void> saveChatMessage(String message) async {
    List<String> chatMessages = _sharedPreferences.getStringList(PrefKeys.chatMessages.toString()) ?? [];
    chatMessages.add(message);
    _sharedPreferences.setStringList(PrefKeys.chatMessages.toString(), chatMessages);
  }

  bool get loggedIn => _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  bool get storeExists => _sharedPreferences.getBool(PrefKeys.storeExist.toString()) ?? false;
  String get token => _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';
  String get name => _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';
  String get email => _sharedPreferences.getString(PrefKeys.email.toString()) ?? '';
  String get id => _sharedPreferences.getString(PrefKeys.id.toString()) ?? '';
  String get craftsmanUserId => _sharedPreferences.getString(PrefKeys.craftsmanUserId.toString()) ?? '';
  String get craftsmanStoreId => _sharedPreferences.getString(PrefKeys.craftsmanStoreId.toString()) ?? '';
  String get password => _sharedPreferences.getString(PrefKeys.password.toString()) ?? '';
  String get phone => _sharedPreferences.getString(PrefKeys.phoneNumber.toString()) ?? '';
  String get typeUser => _sharedPreferences.getString(PrefKeys.typeUser.toString()) ?? '';

  List<String> get chatMessages => _sharedPreferences.getStringList(PrefKeys.chatMessages.toString()) ?? [];

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
import 'package:handcrafts/api/models/store.dart';

class UserApi {
  late int id;
  late String name;
  late String email;
  late String? phoneNumber;
  late String typeUser;
  late String? image_url;
  late int? storeId;
  late String? emailVerifiedAt;
  late String? createdAt;
  late String? updatedAt;
  late String password;
  late Profile? profile;
  late Store? store;

  UserApi() {
    profile = Profile(userId: 0); // Initialize with an empty Profile object
  }

  UserApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image_url = json['image_url'];
    phoneNumber = json['phone_number'];
    typeUser = json['type_user'];
    storeId = json['store_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']): null;
  }
}

class Profile {
  late int userId;
  String? imgProfile; // Image URL can be null if no profile image is available

  Profile({
    required this.userId,
    this.imgProfile,
  });

  Profile.fromJson(Map<String, dynamic> json) {
      userId = json['user_id'];
      imgProfile= json['img_profile'];
  }
}

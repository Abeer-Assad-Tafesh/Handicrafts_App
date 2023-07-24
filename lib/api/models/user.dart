class UserApi {
  late int id;
  late String name;
  late String email;
  late String? phoneNumber;
  late String typeUser;
  late int? storeId;
  late String? emailVerifiedAt;
  late String createdAt;
  late String updatedAt;
  late String password;

  UserApi();

  UserApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    typeUser = json['type_user'];
    storeId = json['store_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
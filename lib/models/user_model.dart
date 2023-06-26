class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? photourl;
  UserModel({
    required uid,
    required name,
    required email,
    required password,
    required photourl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      photourl: json["photourl"] ?? "",
    );
  }
}

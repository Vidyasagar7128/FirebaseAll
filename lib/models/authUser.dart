// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';

List<AuthUser> authUserFromJson(String str) =>
    List<AuthUser>.from(json.decode(str).map((x) => AuthUser.fromJson(x)));

String authUserToJson(List<AuthUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthUser {
  AuthUser({
    this.uid,
    this.email,
    this.name,
    this.image,
  });

  String uid;
  String email;
  String name;
  String image;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        uid: json["uid"],
        email: json["email"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "image": image,
      };
}

// To parse this JSON data, do
//
//     final demoUser = demoUserFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<DemoUser> demoUserFromJson(String str) =>
    List<DemoUser>.from(json.decode(str).map((x) => DemoUser.fromJson(x)));

String demoUserToJson(List<DemoUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DemoUser {
  DemoUser({
    this.name,
    this.age,
    this.demoUserClass,
    this.contact,
  });

  String name;
  String age;
  String demoUserClass;
  var contact;

  factory DemoUser.fromJson(Map<String, dynamic> json) => DemoUser(
        name: json["name"],
        age: json["age"],
        demoUserClass: json["class"],
        contact: json["contact"],
      );
///////////////////////////////////////////////////////

  factory DemoUser.fromFirestore(DocumentSnapshot documentSnapshot) {
    DemoUser user = DemoUser.fromJson(documentSnapshot.data());
    user.name = documentSnapshot.id;
    return user;
  }

///////////////////////////////////////////////////////
  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "class": demoUserClass,
        "contact": contact,
      };
}

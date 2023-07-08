import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(jsonDecode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final ObjectId id;
  final String firstName;
  final String lastName;
  final String address;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "address": address,
  };
}

// To parse this JSON data, do
//
//     final UsersListResponseModel = UsersListResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UsersListResponseModel UsersListResponseModelFromJson(String str) =>
    UsersListResponseModel.fromJson(json.decode(str));

String UsersListResponseModelToJson(UsersListResponseModel data) =>
    json.encode(data.toJson());

class UsersListResponseModel {
  UsersListResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<Datum> data;

  factory UsersListResponseModel.fromJson(Map<String, dynamic> json) =>
      UsersListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.email,
    required this.name,
    required this.inputter,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String email;
  final String name;
  final String inputter;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        inputter: json["inputter"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "inputter": inputter,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

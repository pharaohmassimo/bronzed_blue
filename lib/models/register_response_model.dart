// To parse this JSON data, do
//
//     final RegisterResponseModel = RegisterResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterResponseModel RegisterResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String RegisterResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    RegisterResponseModel({
        required this.success,
        required this.message,
        required this.user,
    });

    final bool success;
    final String message;
    final User user;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        success: json["success"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.username,
        required this.email,
        required this.mobileNumber,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final String username;
    final String email;
    final String mobileNumber;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "mobileNumber": mobileNumber,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}

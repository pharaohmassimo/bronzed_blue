// To parse this JSON data, do
//
//     final addUserModel = addUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddUserModel addUserModelFromJson(String str) => AddUserModel.fromJson(json.decode(str));

String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
    AddUserModel({
        required this.messages,
        required this.data,
    });

    final String messages;
    final Data data;

    AddUserModel copyWith({
        required String messages,
        required Data data,
    }) => 
        AddUserModel(
            messages: messages ,
            data: data,
        );

    factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
        messages: json["messages"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "messages": messages,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.email,
        required this.name,
        required this.inputter,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final String email;
    final String name;
    final String inputter;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    Data copyWith({
        required String email,
        required String name,
        required String inputter,
        required DateTime updatedAt,
        required DateTime createdAt,
        required int id,
    }) => 
        Data(
            email: email ,
            name: name ,
            inputter: inputter ,
            updatedAt: updatedAt ,
            createdAt: createdAt ,
            id: id ,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        name: json["name"],
        inputter: json["inputter"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "inputter": inputter,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}

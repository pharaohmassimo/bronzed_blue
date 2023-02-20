import 'dart:convert';
import 'package:bronzed_blue/models/add_user_model.dart';
import 'package:bronzed_blue/models/login_response_model.dart';
import 'package:bronzed_blue/models/register_response_model.dart';
import 'package:bronzed_blue/models/users_list_model.dart';
import 'package:http/http.dart' as http;

import 'package:bronzed_blue/url_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository {
  ApiRepository();

  Future<LoginResponseModel> authenticateUser(
      {required email, required password}) async {
    var requestBody = jsonEncode({"email": email, "password": password});

    var headers = {
      "Content-Type": "application/json;charset=UTF-8",
      "Charset": "utf-8"
    };
    var url = '${AppStrings.baseUrl}/login';

    try {
      var response =
          await http.post(Uri.parse(url), body: requestBody, headers: headers);

      var body = json.decode(response.body);
      LoginResponseModel authModel = LoginResponseModel.fromJson(body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', authModel.token);

      return authModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RegisterResponseModel> registerUser(
      {required username,
      required password,
      required email,
      required mobileNumber}) async {
    var requestBody = jsonEncode({
      "email": email,
      "password": password,
      "username": username,
      "mobileNumber": mobileNumber,
    });

    var headers = {
      "Content-Type": "application/json;charset=UTF-8",
      "Charset": "utf-8"
    };
    var url = '${AppStrings.baseUrl}/register';

    try {
      var response =
          await http.post(Uri.parse(url), body: requestBody, headers: headers);

      var body = json.decode(response.body);
      RegisterResponseModel regModel = RegisterResponseModel.fromJson(body);

      return regModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AddUserModel> addUser({
    required name,
    required email,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');

    var requestBody = jsonEncode({
      "email": email,
      "token": token,
      "name": name,
    });

    var headers = {
      "Content-Type": "application/json;charset=UTF-8",
      "Charset": "utf-8"
    };
    var url = '${AppStrings.baseUrl}/add-user';

    try {
      var response =
          await http.post(Uri.parse(url), body: requestBody, headers: headers);

      var body = json.decode(response.body);
      AddUserModel addUserResponse = AddUserModel.fromJson(body);

      return addUserResponse;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UsersListResponseModel> displayList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');
    var requestBody = jsonEncode({
      "token": token,
    });

    var headers = {
      "Content-Type": "application/json;charset=UTF-8",
      "Charset": "utf-8"
    };
    var url = '${AppStrings.baseUrl}/show-users';

    try {
      var response =
          await http.post(Uri.parse(url), body: requestBody, headers: headers);

      var body = json.decode(response.body);
      UsersListResponseModel listModel = UsersListResponseModel.fromJson(body);

      return listModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

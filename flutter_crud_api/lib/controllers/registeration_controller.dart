import 'dart:convert';

import 'package:flutter_crud_api/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerEmail);
      Map body = {
        "name": nameController.text,
        "email": emailController.text.trim(),
        "password": passwordController.text
      };

      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          print(token);
          final SharedPreferences? prefs = await _prefs;

          await prefs?.setString('token', token);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.off(HomeScreen());
          //goto home
        } else {
          throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text("Error Occured"),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}

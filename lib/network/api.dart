import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<Map<String, dynamic>>> getUserList() async {
    http.Response response;
    try {
      const String apiPath = "https://api.json-generator.com/templates/-xdNcNKYtTFG/data";
      const String token = "b2atclr0nk1po45amg305meheqf4xrjt9a1bo410";
      response = await http.get(
        Uri.parse(apiPath),
        headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"},
      );
    } on Exception catch (e) {
      log('Network call failed: ${e.toString()}');
      response = http.Response('ERROR: Could not get a response', 404);
    }
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        List<dynamic> responseBody = jsonDecode(response.body);
        List<Map<String, dynamic>> userList = List<Map<String, dynamic>>.from(responseBody);
        return userList;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}

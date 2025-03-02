import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:users_favorites_flutter/utils/user_data.dart';

class ApiProvider {
  Client client = Client();

  Future getUsers(baseUrl, functionUrl) {
    return _doRequest(baseUrl, functionUrl, {});
  }

  Future _doRequest(
      String baseUrl, String functionUrl, Map<String, dynamic> request,
      [Map<String, String> headers = const {}]) async {
    try {
      Map<String, String> innerHeader = {};
      innerHeader.addAll(headers);
      List<dynamic> data = [];
      Response? response;

      response = await client.get(Uri.parse("$baseUrl/$functionUrl"),
          headers: innerHeader);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("response.statusCode: ${response.statusCode}");
          print("response.body: ${response.body}");

          // Decode response as a list
          data = json.decode(response.body);
        }

        return data.map((json) => UserData.fromJson(json)).toList();
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
    }
    return {"success": false};
  }
}

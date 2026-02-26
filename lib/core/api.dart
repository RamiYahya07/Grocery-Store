import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Api {
  //Get Request
  Future<dynamic> get({
    required String url,
    Map<String, String>? headers,
    Map<String,dynamic>? query,
  }) async {
      Uri uri = Uri.parse(url);

  if (query != null) {
    uri = uri.replace(
      queryParameters:
          query.map((key, value) => MapEntry(key, value.toString())),
    );
  }
  final response = await http.get(uri, headers: headers);
    // final response = await http.get(Uri.parse(url), headers: headers);
    final statusMessages = {
      400: 'Bad Request – Your input might be invalid.',
      401: 'Unauthorized Access.',
      403: 'Forbidden – You don’t have permission.',
      404: 'Not Found – Resource not available.',
      500: 'Server error – Please try again later.',
      204:'No Content Found',
    };

    if (response.statusCode == 200) {
      final body = response.body.trim();

      if (body.isEmpty) {
        return null; 
      }

      try {
        return jsonDecode(body);
      } catch (e) {
        print(' JSON decoding failed: $e');
        return null;
      }
    } else if (statusMessages.containsKey(response.statusCode)) {
      return statusMessages[response.statusCode];
    } else {
      throw Exception(
        'There is a problem with status code ${response.statusCode} '
        'with body: ${response.body}',
      );
    }
  }

//Post Request
  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token,
      bool isJson = true}) async {
    Map<String, String> headers = {};
    if (isJson) {
      headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
    } else {
      headers.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
      });
    }
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );
    final statusMessages = {
      400: 'Invalid request, Please try again',
      402: 'Payment Required',
      404: 'Sorry Not Found',
    };
    if (response.statusCode == 200) {
      final body = response.body.trim();

      if (body.isEmpty) {
        return null; 
      }
      try{
      return jsonDecode(response.body);
      }catch (e) {
        print(' JSON decoding failed: $e');
        return null;
      }
    } else if (statusMessages.containsKey(response.statusCode)) {
      return statusMessages[response.statusCode];
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

//Put Method
  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      'Content-Type': 'application/x-www-form-urlencoded',
    });
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
  }

  Future<dynamic> delete({required String url, required String token}) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    final statusMessages = {
      400: 'Bad Request – Your input might be invalid.',
      401: 'Unauthorized Access.',
      403: 'Forbidden – You don’t have permission.',
      404: 'Not Found – Resource not available.',
      500: 'Server error – Please try again later.',
    };

    if (response.statusCode == 200 || response.statusCode == 204) {
      // Successfully deleted, no return needed
      return;
    } else if (statusMessages.containsKey(response.statusCode)) {
      throw Exception(statusMessages[response.statusCode]);
    } else {
      throw Exception(
          'There is a problem with status code ${response.statusCode} with body ${response.body}');
    }
  }
}

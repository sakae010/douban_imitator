import 'dart:io';
import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

typedef RequestCallBack = void Function(Map data);

class HttpRequest {

  final String baseUrl;

  HttpRequest(this.baseUrl);

  static requestGET(
      String authority, String unencodedPath, RequestCallBack callBack,
      Map<String, String>? queryParameters) async {
    try{
      HttpClient httpClient = HttpClient();
      Uri uri = Uri.http(authority, unencodedPath, queryParameters);
      HttpClientRequest request = await httpClient.getUrl(uri);
      HttpClientResponse response = await request.close();
      String responseBody = await response.transform(convert.utf8.decoder).join();
      Map data = convert.jsonDecode(responseBody);
      callBack(data);
    } on Exception catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(Uri.parse(baseUrl + uri), headers: headers);
      int statusCode = response.statusCode;
      String body = response.body;
      if (kDebugMode) {
        print('[uri=$uri][statusCode=$statusCode][response=$body]');
      }
      dynamic result = convert.jsonDecode(body);
      return result;
    }on Exception catch(e) {
      if (kDebugMode) {
        print('[uri=$uri]exception e=${e.toString()}');
      }
      return '';
    }
  }

  Future<dynamic> getResponseBody(String uri, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(Uri.parse(baseUrl + uri), headers: headers);
      int statusCode = response.statusCode;
      String body = response.body;
      if (kDebugMode) {
        print('[uri=$uri][statusCode=$statusCode][response=$body]');
      }
      return body;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('[uri=$uri]exception e=${e.toString()}');
      }
      return null;
    }
  }

  Future<dynamic> post(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.post(Uri.parse(baseUrl + uri), body: body, headers: headers);
      final statusCode = response.statusCode;
      final responseBody = response.body;
      var result = convert.jsonDecode(responseBody);
      if (kDebugMode) {
        print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
      }
      return result;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('[uri=$uri]exception e=${e.toString()}');
      }
      return '';
    }
  }
}

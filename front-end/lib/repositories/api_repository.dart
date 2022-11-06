import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/error_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepository {
  Future<dynamic> get<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.get(
          Uri.parse(model.url).replace(queryParameters: model.params),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      throw Exception("${model.url} ${exception.toString()}");
    }
  }

  Future<dynamic> post<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null && !model.isLogin) {
      model.headers!['Authorization'] = token;
    }
    final res = await http.post(
        Uri.parse(model.url).replace(queryParameters: model.params),
        body: jsonEncode(model.body),
        headers: model.headers);
    return parseResponse(res: res, model: model);
  }

  Future<dynamic> put<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.put(
          Uri.parse(model.url).replace(queryParameters: model.params),
          body: jsonEncode(model.body),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      throw Exception("${model.url} ${exception.toString()}");
    }
  }

  Future<dynamic> delete<T>(ApiModel<T> model) async {
    if (model.headers == null) {
      model.headers = new HashMap();
      model.headers!["Content-Type"] = "application/json;charset=UTF-8";
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      model.headers!['Authorization'] = token;
    }
    try {
      final res = await http.delete(
          Uri.parse(model.url).replace(queryParameters: model.params),
          headers: model.headers);
      return parseResponse(res: res, model: model);
    } catch (exception) {
      throw Exception("${model.url} ${exception.toString()}");
    }
  }

  dynamic parseResponse({res, model}) {
    if (res.statusCode == 200) {
      if (model.parse != null) {
        String data = Utf8Decoder().convert(res.bodyBytes);
        final jsonData = jsonDecode(data);
        return model.parse!(jsonData);
      }
      return res.body;
    } else {
      String data = Utf8Decoder().convert(res.bodyBytes);
      final jsonData = jsonDecode(data);
      ErrorMessage errorMessage = ErrorMessage.fromJson(jsonData);
      throw Exception(errorMessage.message);
    }
  }
}

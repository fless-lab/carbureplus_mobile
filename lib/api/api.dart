import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall {
  final String _url = "http://10.0.2.2:8000/api/auth/";

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeasers());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await getToken();
    //print(fullUrl);
    return await http.get(Uri.parse(fullUrl), headers: _setHeasers());
  }

  fetchPendingOperations(apiUrl) async {
    final response =
        await http.get(Uri.parse(_url + apiUrl + await getToken()));
    return response;
  }

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString("token");
    return '?token=$token';
  }

  _setHeasers() =>
      {"Content-type": "application/json", "Accept": "application/json"};
}

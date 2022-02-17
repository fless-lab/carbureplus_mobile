import 'dart:convert';

import 'package:carbureplus/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall {
  final String _url = "http://$source_ip:8000/api/auth/";

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await getToken();
    //print(fullUrl);
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString("token");
    return '?token=$token';
  }

  _setHeaders() =>
      {"Content-type": "application/json", "Accept": "application/json"};
}

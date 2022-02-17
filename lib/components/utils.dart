import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

const loading = FittedBox(
  child: SpinKitThreeBounce(
    color: Colors.white,
    size: 20,
  ),
);

loadPrefUser() async {
  var userData;
  await SharedPreferences.getInstance().then((prefs) {
    userData = prefs.getString("user"); //user type = string
    userData = json.decode(
        userData!); //user type = _InternalLinkedHashMap<String, dynamic>
  });
  return userData;
}

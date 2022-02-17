import 'dart:convert';

import 'package:carbureplus/api/api.dart';
import 'package:carbureplus/components/drawer.dart';
import 'package:carbureplus/components/utils.dart';
import 'package:carbureplus/constants.dart';
import 'package:carbureplus/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  "Authentifiez-vous",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15)),
                  child: Text(
                    "Veuillez vous connecter pour accéder à votre compte Carbure +",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(15),
                  right: getProportionateScreenWidth(15)),
              //height: size.shortestSide,
              width: size.shortestSide,
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(26)),
              ),
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: getProportionateScreenHeight(13)),
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            blurRadius: (5),
                            color: Colors.white24),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_iphone),
                              labelText: " Numéro de téléphone*"),
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              labelText: "  Mot de passe*"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(12)),
                          child: Text("$errorMessage",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(10)),
                          child: SizedBox(
                            width: size.shortestSide,
                            child: FlatButton(
                              onPressed: () {
                                _login();
                              },
                              child: _isLoading
                                  ? loading
                                  : Text(
                                      "SE CONNECTER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                              color: mainColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text(
              "Carbure + , vendez plus éfficacement !",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    if (phoneController.text != "" && passwordController.text != "") {
      setState(() {
        _isLoading = true;
        errorMessage = "";
      });

      var data = {
        "phone": phoneController.text,
        "password": passwordController.text
      };
      try {
        var res = await ApiCall().postData(data, "login");
        var body = json.decode(res.body);
        print(body);
        if (body != null && body["success"]) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.setString("token", body["access_token"]);
          localStorage.setString("user", json.encode(body["user"]));
          localStorage.setBool("isLoggedIn", true);

          setState(() {
            _isLoading = false;
          });

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyDrawer()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            _isLoading = false;
            errorMessage = body["message"];
          });
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
          errorMessage = "Une erreur est survenu. Veuillez réessayer plutard";
        });
        print("$error");
      }
    } else {
      setState(() {
        errorMessage = "Veuillez remplir tous les champs.";
      });
    }
  }
}

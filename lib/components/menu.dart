import 'dart:convert';

import 'package:carbureplus/api/api.dart';
import 'package:carbureplus/components/utils.dart';
import 'package:carbureplus/constants.dart';
import 'package:carbureplus/models/menu_item.dart';
import 'package:carbureplus/screens/login.dart';
import 'package:carbureplus/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItems {
  static const home = MenuItem("Accueil", Icons.home_outlined);
  static const transactions = MenuItem("Transactions", Icons.payment);
  static const account = MenuItem("Mon compte", Icons.person_outlined);
  static const help = MenuItem("Assistance", Icons.help);
  static const about = MenuItem("À Propos", Icons.info_outlined);

  static const all = <MenuItem>[home, transactions, account, help, about];
}

class MenuPage extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var user;

  Future<void> _loadUser() async {
    await SharedPreferences.getInstance().then((prefs) {
      user = prefs.getString("user"); //user type = string
      user = json
          .decode(user!); //user type = _InternalLinkedHashMap<String, dynamic>
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 2),
              FutureBuilder(
                future: _loadUser(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${imgUrl + user["photo_profile"]}"),
                                    fit: BoxFit.fill),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.5)),
                            width: getProportionateScreenWidth(120),
                            height: getProportionateScreenWidth(120),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Text(
                            "${user["prenom"]} ${user["nom"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  }
                  return loading; //Ajouter un padding peut etre plutard
                },
              ),
              Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(),
              GestureDetector(
                onTap: _logout,
                child: Container(
                  width: getProportionateScreenWidth(160),
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_rounded),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      Text(
                        "Déconnexion",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: widget.currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => widget.onSelectedItem(item),
        ),
      );

  void _logout() async {
    var res = await ApiCall().getData("logout");
    var body = json.decode(res.body);
    print(body);
    if (body["success"]) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove("user");
      localStorage.remove("token");
      localStorage.setBool("isLoggedIn", false);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }
}

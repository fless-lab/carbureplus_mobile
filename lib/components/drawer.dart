import 'dart:convert';

import 'package:carbureplus/models/menu_item.dart';
import 'package:carbureplus/models/user.dart';
import 'package:carbureplus/screens/about.dart';
import 'package:carbureplus/screens/account.dart';
import 'package:carbureplus/screens/assistant.dart';
import 'package:carbureplus/screens/home.dart';
import 'package:carbureplus/screens/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  MenuItem currentItem = MenuItems.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ZoomDrawer(
      style: DrawerStyle.Style1,
      borderRadius: 30,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      showShadow: true,
      backgroundColor: Colors.lightBlueAccent,
      menuScreen: Builder(
        builder: (context) => MenuPage(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() {
              currentItem = item;
            });
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
      mainScreen: getScreen());

  getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return HomePage();
      case MenuItems.transactions:
        return TransactionsPage();
      case MenuItems.account:
        return AccountPage();
      case MenuItems.help:
        return AssistantPage();
      case MenuItems.about:
        return AboutPage();
    }
  }
}

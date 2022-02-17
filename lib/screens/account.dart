import 'package:carbureplus/components/open_drawer.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: OpenDrawer(),
        title: Text(
          "Mon Compte",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
    );
  }
}

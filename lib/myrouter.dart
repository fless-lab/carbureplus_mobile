import 'package:carbureplus/constants.dart';
import 'package:flutter/material.dart';
import 'package:carbureplus/screens/home.dart';
import 'package:carbureplus/screens/transactions.dart';

class MyRouter extends StatefulWidget {
  const MyRouter({Key? key}) : super(key: key);

  @override
  _MyRouterState createState() => _MyRouterState();
}

class _MyRouterState extends State<MyRouter> {
  final screens = [HomePage(), TransactionPage()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: mainColor,
        selectedFontSize: 17,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Accueil"),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_rows_rounded),
            label: "Transactions",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

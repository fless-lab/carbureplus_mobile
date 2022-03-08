import 'package:carbureplus/components/drawer.dart';
import 'package:carbureplus/constants.dart';
import 'package:carbureplus/myrouter.dart';
import 'package:carbureplus/screens/home.dart';
import 'package:carbureplus/screens/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //Forcer l'application à garder le mode portrait
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences ls = await SharedPreferences.getInstance();
    var loggedIn = ls.getBool("isLoggedIn");
    if (loggedIn != null) {
      setState(() {
        _isLoggedIn = loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //key: UniqueKey(),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('fr')],
      debugShowCheckedModeBanner: false,
      title: 'Carbure +',
      theme: ThemeData(
          fontFamily: "Comfortaa",
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blueGrey,
          primaryColor: mainColor),
      home: _isLoggedIn ? MyDrawer() : LoginPage(),
    );
  }
}

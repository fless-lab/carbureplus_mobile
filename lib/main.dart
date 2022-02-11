import 'package:carbureplus/constants.dart';
import 'package:carbureplus/myrouter.dart';
import 'package:carbureplus/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //Forcer l'application à garder le mode portrait
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carbure +',
      theme: ThemeData(
          fontFamily: "Comfortaa",
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: mainColor),
      home: MyRouter(),
    );
  }
}

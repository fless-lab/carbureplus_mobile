import 'package:carbureplus/components/open_drawer.dart';
import 'package:flutter/material.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: OpenDrawer(),
        title: Text(
          "Besoin d'aide ?",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
    );
  }
}

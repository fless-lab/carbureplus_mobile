import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class OpenDrawer extends StatelessWidget {
  const OpenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => ZoomDrawer.of(context)!.toggle(),
      );
}

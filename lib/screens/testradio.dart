import 'package:flutter/material.dart';

class RadioTest extends StatefulWidget {
  const RadioTest({Key? key}) : super(key: key);

  @override
  _RadioTestState createState() => _RadioTestState();
}

class _RadioTestState extends State<RadioTest> {
  var selectedStyle;
  int? groupValue;
  static const styles = ["Normal", "Italic", "Bold"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Boutons Radio"),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, id) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      value: id,
                      groupValue: groupValue,
                      toggleable: true,
                      onChanged: (int? value) {
                        setState(() {
                          selectedStyle = styles[id];
                          groupValue = value;
                        });
                      }),
                  Text(styles[id]),
                ],
              );
            },
            itemCount: styles.length,
          ),
          Divider(),
          selectedStyle != null
              ? Text("Le style sélectionné est : $selectedStyle")
              : Container(),
        ],
      ),
    );
  }
}

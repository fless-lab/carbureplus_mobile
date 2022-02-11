import 'package:carbureplus/constants.dart';
import 'package:carbureplus/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      extendBody: true,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(15),
                right: getProportionateScreenWidth(15),
                top: getProportionateScreenHeight(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Carbure +",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(24),
                top: getProportionateScreenHeight(25)),
            child: Text(
              "Bonjour Abdou-Raouf !",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(25)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 10),
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 50)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15),
                  horizontal: getProportionateScreenWidth(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mardi, 12 fev. 2022",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: mainColor),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '17000 fcfa',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: mainColor,
                        ),
                      ),
                      Text(
                        'Total des ventes',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(40),
                left: getProportionateScreenWidth(15),
                right: getProportionateScreenWidth(15)),
            height: size.longestSide,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36), topRight: Radius.circular(26)),
            ),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Effectuer une vente ...",
                            style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(150),
                            child: Divider(),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: getProportionateScreenHeight(13)),
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(15)),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: (5),
                                color: flow),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Colors.white,
                        ),
                        child: Text("oj"),
                      ),
                    ],
                  ),
                ),
                Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}

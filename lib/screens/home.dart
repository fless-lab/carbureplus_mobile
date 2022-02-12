import 'package:carbureplus/constants.dart';
import 'package:carbureplus/models/pm_dropdown.dart';
import 'package:carbureplus/models/transaction.dart';
import 'package:carbureplus/screens/transactions.dart';
import 'package:carbureplus/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var paymentMethodsItems = loadPaymentMethods();
  var selectedPaymentMethod;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      extendBody: true,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(15),
                right: getProportionateScreenWidth(15),
              ),
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
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
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
              //height: size.shortestSide,
              width: size.shortestSide,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(26)),
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
                          child: Column(
                            children: [
                              SizedBox(
                                width: size.shortestSide,
                                child: DropdownButton<PaymentMethod>(
                                  hint: Text("Choisissez un moyen de payement"),
                                  items: paymentMethodsItems
                                      .map((item) =>
                                          DropdownMenuItem<PaymentMethod>(
                                              value: item,
                                              child: Text(item.title)))
                                      .toList(),
                                  value: selectedPaymentMethod,
                                  onChanged: (item) {
                                    setState(() {
                                      selectedPaymentMethod = item;
                                    });
                                  },
                                ),
                              ),
                              TextFormField(
                                //controller: villeDepartController,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.monetization_on_outlined),
                                    labelText: " Montant (fcfa)*"),
                              ),
                              TextFormField(
                                //controller: villeDepartController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone_iphone),
                                    labelText: " Numéro Flooz*"),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(12)),
                                child: Text("Une erreur s'est produite.",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(10)),
                                child: SizedBox(
                                  width: size.shortestSide,
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      "PROCÉDER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    color: mainColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: getProportionateScreenHeight(50)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transaction récentes",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: mainColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TransactionsPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Tout voir",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            )
                          ],
                        ),
                        Container(child: transactionsList()),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget transactionsList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          //padding: EdgeInsets.only(bottom: getProportionateScreenHeight(50)),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return transactionCard(2);
          }),
    );
  }

  Widget transactionCard(transaction) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: Container(
        //color: Colors.red,
        //width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
        child: GestureDetector(
          onTap: () {},
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15),
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(),
                  Column(
                    children: [Text("1350"), Text("via t-money")],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

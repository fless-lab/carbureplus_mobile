import 'dart:convert';

import 'package:carbureplus/api/api.dart';
import 'package:carbureplus/components/open_drawer.dart';
import 'package:carbureplus/components/utils.dart';
import 'package:carbureplus/constants.dart';
import 'package:carbureplus/screens/transactions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:carbureplus/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> paymentMethods = ["T-Money", "Flooz", "Bon"];
  var selectedTransaction;
  Color inactiveColor = Colors.grey;
  var selectedPaymentMethod;
  bool bonIsSelected = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bonAmountController = TextEditingController();
  String errorMessage = "";
  Color transactionTextColor = mainColor;
  var user;
  var mytransactions;
  bool isTransactionsListLoaded = false;
  bool isTodaySaleGot = false;
  bool saleLoading = false;
  var ventesTotalesToday;

  Future<void> _loadUser() async {
    await SharedPreferences.getInstance().then((prefs) {
      user = prefs.getString("user"); //user type = string
      user = json
          .decode(user!); //user type = _InternalLinkedHashMap<String, dynamic>
    });
    return user;
  }

  _getTransactions() async {
    setState(() {
      isTransactionsListLoaded = false;
    });
    final response = await http.get(
        Uri.parse(baseUrl + "get_transactions" + await ApiCall().getToken()));
    if (response.statusCode == 200) {
      mytransactions = json.decode(response.body)["transactions"];
      setState(() {
        isTransactionsListLoaded = true;
      });
      return mytransactions;
    }
  }

  _getTodaySale() async {
    setState(() {
      isTodaySaleGot = false;
    });
    final response = await http.get(
        Uri.parse(baseUrl + "get_today_sale" + await ApiCall().getToken()));
    if (response.statusCode == 200) {
      ventesTotalesToday = json.decode(response.body)["total"];
      setState(() {
        isTodaySaleGot = true;
      });
      print(response.body);
      return ventesTotalesToday;
    }
  }

  _transactionColorManager(transaction) {
    if (transaction["status"] == "succeed") {
      return Colors.green;
    } else if (transaction["status"] == "failed") {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _getTransactions();
    _getTodaySale();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    bonAmountController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: mainColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: OpenDrawer(),
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        backgroundColor: mainColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: getProportionateScreenWidth(10),
                top: getProportionateScreenHeight(25)),
            child: Text(
              "Carbure +",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _loadUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _body();
              }
              return Center(child: loading);
            }),
      ),
    );
  }

  Widget _body() => ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(24),
                top: getProportionateScreenHeight(10)),
            child: Text(
              "Bonjour ${user["prenom"]} !",
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
                    "${DateFormat("EEEE, d MMM yyyy", "fr").format(DateTime.now())}",
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
                        '${isTodaySaleGot ? ventesTotalesToday : "-"} fcfa',
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
            //height: size.shortestSide,
            width: MediaQuery.of(context).size.shortestSide,
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
                              width: MediaQuery.of(context).size.shortestSide,
                              child: DropdownButton<String>(
                                hint: Text("Choisissez un moyen de payement"),
                                items: paymentMethods
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item, child: Text(item)))
                                    .toList(),
                                value: selectedPaymentMethod,
                                onChanged: (item) {
                                  if (item == paymentMethods[2]) {
                                    setState(() {
                                      bonIsSelected = true;
                                    });
                                  }
                                  setState(() {
                                    selectedPaymentMethod = item;
                                  });
                                },
                              ),
                            ),
                            TextFormField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.monetization_on_outlined),
                                  labelText: " Montant du carburant (fcfa)*"),
                            ),
                            (selectedPaymentMethod == "Bon")
                                ? TextFormField(
                                    controller: bonAmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                            Icons.monetization_on_outlined),
                                        labelText: " Valeur du bon (fcfa)*"),
                                  )
                                : Container(),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_iphone),
                                  labelText:
                                      " Numéro${selectedPaymentMethod != "Bon" ? "" : "(Si il y'a monnaie à prendre)"} ${selectedPaymentMethod ?? ""}*"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(12)),
                              child: Text("$errorMessage",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(10)),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.shortestSide,
                                child: FlatButton(
                                  onPressed: () {
                                    _proceedSale();
                                  },
                                  child: saleLoading
                                      ? FittedBox(
                                          child: SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        )
                                      : Text(
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
                      Container(
                        child: isTransactionsListLoaded
                            ? transactionsList()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(20)),
                                child: Shimmer.fromColors(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(
                                                getProportionateScreenWidth(
                                                    20)),
                                            margin: EdgeInsets.all(
                                                getProportionateScreenWidth(5)),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black26)),
                                          );
                                        }),
                                    baseColor: Colors.grey[300] ?? Colors.grey,
                                    highlightColor: Colors.white)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
  Widget transactionsList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      child: (mytransactions.length == 0)
          ? Center(child: Text("Aucune transaction éffectuée."))
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mytransactions.length < 5 ? mytransactions.length : 5,
              itemBuilder: (context, index) {
                var transacts = mytransactions.take(5);
                return transactionCard(transacts.elementAt(index));
              }),
    );
  }

  Widget transactionCard(transaction) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(getProportionateScreenWidth(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selectedTransaction == transaction
                  ? mainColor
                  : Colors.black26)),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedTransaction = transaction;
          });
        },
        leading: Image.asset(
          "assets/images/${transaction["status"]}.png",
          color: selectedTransaction == transaction
              ? _transactionColorManager(transaction)
              : inactiveColor,
          width: getProportionateScreenWidth(35),
        ),
        title: Text(
          "${transaction["montant"]} (Via ${transaction["payment_method"]})",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedTransaction == transaction
                  ? transactionTextColor
                  : inactiveColor),
        ),
        subtitle: Text(
            "${transaction["moyen"] != "Bon" ? "+228" : ""} ${transaction["phone"]}"),
        trailing: Text(
          //"${DateFormat("HH:mm", "fr").format(DateTime.now())}",
          "${transaction["action_date"].split(" ").last}",
          style: TextStyle(
              color: selectedTransaction == transaction
                  ? transactionTextColor
                  : inactiveColor,
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  _proceedSale() async {
    setState(() {
      saleLoading = true;
    });
    if (selectedPaymentMethod == null) {
      setState(() {
        errorMessage = "Veuillez séléctionner le moyen de payement.";
      });
    } else if (selectedPaymentMethod == "Bon") {
      if (amountController.text != "" && bonAmountController.text != "") {
        int monnaie = int.parse(bonAmountController.text) -
            int.parse(amountController.text);
        if (monnaie < 0) {
          setState(() {
            errorMessage =
                "Erreur !!! Le montant est supérieur à la valeur du bon.";
          });
        } else {
          if (monnaie > 0 && phoneController.text == "") {
            setState(() {
              errorMessage =
                  "Vous devriez renseigner un numéro pour l'envoie de la monnaie.";
            });
          } else {
            //Proceder à la vente via bon de carburant
            var data = {
              "valeur_bon": bonAmountController.text,
              "phone": phoneController.text,
              "montant": amountController.text,
            };
            var res =
                await ApiCall().postData(data, "make_transaction_via_bon");
            var body = json.decode(res.body);
            if (body["success"] != null && body["success"]) {
              setState(() {
                saleLoading = false;
              });
              _getTransactions();
              _getTodaySale();
              //On réinitialise les champs.
              phoneController.clear();
              amountController.clear();
              bonAmountController.clear();
            } else {
              setState(() {
                saleLoading = false;
                //errorMessage = body["message"];
              });
            }
          }
        }
      } else {
        setState(() {
          errorMessage = 'Veuillez remplir tous les champs svp.';
        });
      }
    } else if (selectedPaymentMethod != "Bon") {
      if (amountController.text != "" && phoneController.text != "") {
        //Proceder à la vente via mobile-money (Flooz/T-Money)
        var data = {
          "payment_method": selectedPaymentMethod,
          "phone": phoneController.text,
          "montant": amountController.text,
        };
        var res = await ApiCall().postData(data, "make_transaction_via_mm");
        var body = json.decode(res.body);
        print(body);
        if (body["success"] != null && body["success"]) {
          setState(() {
            saleLoading = false;
          });
          _getTransactions();
          _getTodaySale();
          //On réinitialise les champs.
          phoneController.clear();
          amountController.clear();
        } else {
          //Dans le cas où la requete echoue...
          setState(() {
            saleLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Veuillez remplir tous les champs svp.";
        });
      }
    }
  }
}

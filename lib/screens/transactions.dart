import 'dart:convert';

import 'package:carbureplus/api/api.dart';
import 'package:carbureplus/components/open_drawer.dart';
import 'package:carbureplus/size_config.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import '../constants.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  var mytransactions;
  bool isTransactionsListLoaded = false;
  _transactionColorManager(transaction) {
    if (transaction["status"] == "succeed") {
      return Colors.green;
    } else if (transaction["status"] == "failed") {
      return Colors.red;
    } else {
      return Colors.orange;
    }
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

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: OpenDrawer(),
        title: Text(
          "Mes Transactions",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: isTransactionsListLoaded
          ? transactionsList()
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget transactionsList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      child: (mytransactions.length == 0)
          ? Center(child: Text("Aucune transaction éffectuée."))
          : ListView.builder(
              itemCount: mytransactions.length,
              itemBuilder: (context, index) {
                var transacts = mytransactions;
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
          border: Border.all(color: Colors.black26)),
      child: ListTile(
        leading: Image.asset(
          "assets/images/${transaction["status"]}.png",
          color: _transactionColorManager(transaction),
          width: getProportionateScreenWidth(35),
        ),
        title: Text(
          "${transaction["montant"]} (Via ${transaction["payment_method"]})",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
            "${transaction["moyen"] != "Bon" ? "+228" : ""} ${transaction["phone"]}"),
        trailing: Text(
          //"${DateFormat("HH:mm", "fr").format(DateTime.now())}",
          "${transaction["action_date"]}",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

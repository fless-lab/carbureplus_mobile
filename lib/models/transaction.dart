import 'package:flutter/material.dart';

class Transaction {
  final int montant;
  final String moyen, phone, status;
  final DateTime date;

  Transaction({
    required this.montant,
    required this.moyen,
    required this.phone,
    required this.status,
    required this.date,
  });
}

List<Transaction> loadTransactions() {
  var t = [
    Transaction(
      montant: 1500,
      moyen: "T-Money",
      phone: "96858733",
      date: DateTime.now(),
      status: "failed",
    ),
    Transaction(
      montant: 1500,
      moyen: "Bon",
      phone: "IUJ64-710",
      date: DateTime.now(),
      status: "pending",
    ),
    Transaction(
      montant: 800,
      moyen: "Flooz",
      phone: "79564322",
      date: DateTime.now(),
      status: "succeed",
    ),
    Transaction(
      montant: 10500,
      moyen: "T-Money",
      phone: "70564357",
      date: DateTime.now(),
      status: "pending",
    ),
    Transaction(
      montant: 1000,
      moyen: "Bon",
      phone: "SIJ76-018",
      date: DateTime.now(),
      status: "succeed",
    ),
    Transaction(
      montant: 1500,
      moyen: "Flooz",
      phone: "99806622",
      date: DateTime.now(),
      status: "failed",
    ),
    Transaction(
      montant: 2300,
      moyen: "Flooz",
      phone: "96858733",
      date: DateTime.now(),
      status: "pending",
    ),
    Transaction(
      montant: 3750,
      moyen: "Bon",
      phone: "DTG18-032",
      date: DateTime.now(),
      status: "pending",
    ),
    Transaction(
      montant: 505,
      moyen: "T-Money",
      phone: "90975489",
      date: DateTime.now(),
      status: "succeed",
    ),
  ];
  return t;
}

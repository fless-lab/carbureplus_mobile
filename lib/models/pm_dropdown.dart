import 'package:flutter/material.dart';

class PaymentMethod {
  final String title;
  final Widget imbededWidget;

  PaymentMethod({required this.title, required this.imbededWidget});
}

List<PaymentMethod> loadPaymentMethods() {
  var pm = [
    PaymentMethod(title: "T-Money", imbededWidget: Text("")),
    PaymentMethod(title: "Flooz", imbededWidget: Text("")),
    PaymentMethod(title: "Bon de carburant", imbededWidget: Text("")),
  ];
  return pm;
}

import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier {
  double saldo = 0;

  Saldo(this.saldo);

  adiciona(double valor) {
    this.saldo += valor;
    notifyListeners();
  }

  subtrai(double valor) {
    this.saldo += valor;
    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $saldo';
  }
}

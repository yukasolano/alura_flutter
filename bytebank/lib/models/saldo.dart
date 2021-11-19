import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier {
  double saldo = 0;

  Saldo(this.saldo);

  @override
  String toString() {
    return 'R\$ $saldo';
  }
}

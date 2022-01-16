import 'package:alura_flutter/models/transferencia.dart';
import 'package:flutter/material.dart';

class Transferencias extends ChangeNotifier {
  final List<Transferencia> _transferencias = [];

  List<Transferencia> get transferencias => _transferencias;

  adiciona(Transferencia transferencia) {
    transferencias.add(transferencia);
    notifyListeners();
  }
}

import 'package:alura_flutter/models/saldo.dart';
import 'package:flutter/material.dart';

import 'saldo_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bytebank'),
        ),
        body: Align(alignment: Alignment.topCenter, child: SaldoCard()));
  }
}

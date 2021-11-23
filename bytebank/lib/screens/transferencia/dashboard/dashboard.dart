import 'package:alura_flutter/screens/transferencia/deposito/formulario_deposito.dart';
import 'package:alura_flutter/screens/transferencia/transferencia/formulario.dart';
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
        body: ListView(
          children: <Widget>[
            Align(alignment: Alignment.topCenter, child: SaldoCard()),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Fazer depósito'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormularioDeposito();
                    }));
                  },
                ),
                ElevatedButton(
                  child: Text('Nova transferência'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormularioTransferencia();
                    }));
                  },
                )
              ],
            )
          ],
        ));
  }
}

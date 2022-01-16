import 'package:alura_flutter/models/Transferencias.dart';
import 'package:alura_flutter/screens/transferencia/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String _titulo = 'Últimas transferências';

class UltimasTransfencias extends StatelessWidget {
  const UltimasTransfencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_titulo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Consumer<Transferencias>(builder: (context, transferencias, child) {
          final _ultimasTransferencias =
              transferencias.transferencias.reversed.toList();
          final _quantidade = transferencias.transferencias.length;

          if (_quantidade == 0) {
            return SemTransferenciaCadastrada();
          }

          final _tamanho = _quantidade < 3 ? _quantidade : 2;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: _tamanho,
            itemBuilder: (context, indice) {
              return ItemTransferencia(_ultimasTransferencias[indice]);
            },
          );
        }),
        ElevatedButton(
          child: Text('Ver todas ransferências'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListaTransferencias();
            }));
          },
        )
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Você ainda não realizou nenhuma transferência',
            textAlign: TextAlign.center,
          )),
    );
  }
}

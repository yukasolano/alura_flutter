import 'package:alura_flutter/models/transfer.dart';
import 'package:flutter/material.dart';

import 'transfer_form.dart';

const _tituloAppBar = 'Transferência';

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transfers[indice];
          return TransferItem(transferencia);
        },
      ),
      appBar: AppBar(title: Text(_tituloAppBar)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          })).then((transferencia) => _update(transferencia));
        },
      ),
    );
  }

  void _update(transfer) {
    if (transfer != null) {
      setState(() {
        widget._transfers.add(transfer);
      });
    }
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = [];

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

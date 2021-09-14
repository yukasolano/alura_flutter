import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transfer Feed';

class FeedListState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    //widget._transfers.add(Transaction(100.0, Contact(0, 'Alex', 1000)));
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transfers[indice];
          return TransferItem(transferencia);
        },
      ),
      appBar: AppBar(title: Text(_tituloAppBar)),
    );
  }
}

class Feed extends StatefulWidget {
  final List<Transaction> _transfers = [];

  @override
  State<StatefulWidget> createState() {
    return FeedListState();
  }
}

class TransferItem extends StatelessWidget {
  final Transaction _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          _transfer.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          )
        ),
        subtitle: Text(
            _transfer.contact.accountNumber.toString(),
            style: TextStyle(
              fontSize: 16.0,
            )
        ),
      ),
    );
  }
}

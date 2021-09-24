import 'package:alura_flutter/components/centered_message.dart';
import 'package:alura_flutter/components/progress.dart';
import 'package:alura_flutter/http/webclient.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transfer Feed';

class FeedListState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    //widget._transfers.add(Transaction(100.0, Contact(0, 'Alex', 1000)));
    return Scaffold(
      body: FutureBuilder<List<Transaction>>(
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if(snapshot.hasData) {
                  final List<Transaction>? transactions = snapshot.data;
                  if(transactions!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, indice) {
                        final transferencia = transactions[indice];
                        return TransferItem(transferencia);
                      },
                    );
                  }
                }
                return CenteredMessage('No transaction found', icon: Icons.warning);
            }
            return CenteredMessage('Unkown error');
          }),
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
        title: Text(_transfer.value.toString(),
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text(_transfer.contact.accountNumber.toString(),
            style: TextStyle(
              fontSize: 16.0,
            )),
      ),
    );
  }
}

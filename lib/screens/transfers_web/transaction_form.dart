import 'dart:async';

import 'package:alura_flutter/components/auth_dialog.dart';
import 'package:alura_flutter/components/progress.dart';
import 'package:alura_flutter/components/response_dialog.dart';
import 'package:alura_flutter/http/webclients/transaction_webclient.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:alura_flutter/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  bool _sending = false;
  final String transactionId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(message: "Sending..."),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      if (value == null) {
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return FailureDialog(
                                  'please select a value for the transaction');
                            });
                      } else {
                        final transactionCreated =
                            Transaction(transactionId, value, widget.contact);
                        showDialog(
                            context: context,
                            builder: (contextDialog) {
                              return AuthDialog(onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              });
                            });
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final dependencies = AppDependencies.of(context);
    final Transaction? transaction =
        await dependencies!.transactionWebClient.save(transactionCreated, password)!.catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context,
          message: 'timeout submitting the transaction');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _sending = false;
        });
    });

    _showSuccessulMessage(transaction, context);
  }

  Future<void> _showSuccessulMessage(Transaction? transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("successful transaction");
          });
      Navigator.pop(context);
    }
  }

  void _showFailureMessage(BuildContext context, {message = 'unknown error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}

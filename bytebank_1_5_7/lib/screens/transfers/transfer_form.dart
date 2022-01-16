import 'package:alura_flutter/components/editor.dart';
import 'package:alura_flutter/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Creating transfer';
const _valueLabel = 'Value';
const _valueTip = '0.00';
const _accountNumberLabel = 'Account number';
const _accountNumberTip = '0000';
const _confirmButton = 'Confirm';

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final double? value = double.tryParse(_valueController.text);
    if (accountNumber != null && value != null) {
      final createdTransfer = Transfer(value, accountNumber);
      Navigator.pop(context, createdTransfer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_appBarTitle)),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Editor(
              controller: _accountNumberController,
              rotulo: _accountNumberLabel,
                dica: _accountNumberTip,
                typeNumber: "yes",),
            Editor(
                controller: _valueController,
                rotulo: _valueLabel,
                dica: _valueTip,
                icone: Icons.monetization_on,
                typeNumber: "yes"),
            ElevatedButton(
                onPressed: () => _createTransfer(context),
                child: Text(_confirmButton))
          ]),
        ));
  }
}

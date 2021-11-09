import 'package:alura_flutter/components/editor.dart';
import 'package:alura_flutter/database/dao/contacts_dao.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'New contact';
const _nameLabel = 'Full name';
const _accountNumberLabel = 'Account number';
const _accountNumberTip = '0000';
const _createButton = 'Create';

class ContactForm extends StatefulWidget {

  final ContactDao contactDao;

  const ContactForm({required this.contactDao});

  @override
  State<StatefulWidget> createState() {
    return ContactFormState();
  }
}

class ContactFormState extends State<ContactForm> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  void _createContact(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final String? name = _valueController.text;
    if (accountNumber != null && name != null) {
      final createdContact = Contact(0, name, accountNumber);
      _save(createdContact, context);
    }
  }

  void _save(Contact createdContact, BuildContext context) async {
    await widget.contactDao.save(createdContact);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Editor(controller: _valueController, rotulo: _nameLabel),
          Editor(
              controller: _accountNumberController,
              rotulo: _accountNumberLabel,
              dica: _accountNumberTip,
              typeNumber: "yes"),
          ElevatedButton(
              onPressed: () => _createContact(context),
              child: Text(_createButton))
        ]),
      ),
    );
  }
}

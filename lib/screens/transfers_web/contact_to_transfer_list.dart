import 'package:alura_flutter/components/progress.dart';
import 'package:alura_flutter/database/dao/contacts_dao.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/screens/contact/contact_form.dart';
import 'package:alura_flutter/screens/transfers_web/transaction_form.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Contacts';

class ContactToTransferList extends StatefulWidget {

  final ContactDao contactDao;

  const ContactToTransferList({required this.contactDao});

  @override
  _ContactToTransferListState createState() => _ContactToTransferListState(contactDao: contactDao);
}

class _ContactToTransferListState extends State<ContactToTransferList> {
  final ContactDao contactDao;

  _ContactToTransferListState({required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: contactDao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data as List<Contact>;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return ContactItem(contacts[index], onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TransactionForm(contact),
                      ));
                    });
                  },
                );
            }
            return Text('Unknown error');
          }),
      appBar: AppBar(title: Text(_appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactForm(contactDao: contactDao);
          })).then((value) => setState(() {}));
        },
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  ContactItem(this.contact, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(contact.name.toString()),
        subtitle: Text(contact.accountNumber.toString()),
      ),
    );
  }
}

import 'package:alura_flutter/database/dao/contacts_dao.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/screens/contact/contact_form.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Contacts';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: _dao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text('Loading'),
                    ],
                  ),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data as List<Contact>;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ContactItem(contacts[index]);
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
            return ContactForm();
          })).then((value) => setState(() {}));
        },
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact _contact;

  ContactItem(this._contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_contact.name.toString()),
        subtitle: Text(_contact.accountNumber.toString()),
      ),
    );
  }
}

import 'package:alura_flutter/components/bloc_container.dart';
import 'package:alura_flutter/components/progress.dart';
import 'package:alura_flutter/database/dao/contacts_dao.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/screens/contact/contact_form.dart';
import 'package:alura_flutter/screens/transfers_web/transaction_form.dart';
import 'package:alura_flutter/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _appBarTitle = 'Contacts';

@immutable
abstract class ContactsListState {
  const ContactsListState();
}

@immutable
class InitContactsListState extends ContactsListState {
  const InitContactsListState();
}

@immutable
class LoadingContactsListState extends ContactsListState {
  const LoadingContactsListState();
}

@immutable
class LoadedContactsListState extends ContactsListState {
  final List<Contact> _contacts;

  const LoadedContactsListState(this._contacts);
}

@immutable
class FatalErrorContactsListState extends ContactsListState {
  const FatalErrorContactsListState();
}

class ContactListCubit extends Cubit<ContactsListState> {
  ContactListCubit() : super(InitContactsListState());

  void reload(ContactDao dao) async {
    emit(LoadingContactsListState());
    dao.findAll()!.then((contacts) => emit(LoadedContactsListState(contacts)));
  }

  @override
  void onChange(Change<ContactsListState> change) {
    super.onChange(change);
    print(change);
  }
}

class ContactToTransferListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return BlocProvider<ContactListCubit>(
        create: (BuildContext context) {
          final cubit = ContactListCubit();
          cubit.reload(dependencies!.contactDao);
          return cubit;
        },
        child: ContactToTransferList(dependencies!.contactDao));
  }
}

class ContactToTransferList extends StatefulWidget {
  final ContactDao _dao;
  ContactToTransferList(this._dao);

  @override
  _ContactToTransferListState createState() => _ContactToTransferListState();
}

class _ContactToTransferListState extends State<ContactToTransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContactListCubit, ContactsListState>(
          builder: (context, state) {
        if (state is InitContactsListState ||
            state is LoadingContactsListState) {
          return Progress();
        }
        if (state is LoadedContactsListState) {
          final List<Contact> contacts = state._contacts;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final Contact contact = contacts[index];
              return ContactItem(contacts[index], onClick: () {
                ContactToTransferListContainer().push(context, TransactionFormContainer(contact));
              });
            },
          );
        }
        return Text('Unknown error');
      }),
      appBar: AppBar(title: Text(_appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactForm();
          }));
          context.read<ContactListCubit>().reload(widget._dao);
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

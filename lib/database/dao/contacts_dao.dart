import 'package:alura_flutter/database/app_database.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String _table = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  static const String tableSql = 'CREATE TABLE $_table('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT,'
      '$_accountNumber INTEGER)';

  Future<int> save(Contact contato) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contato.name;
    contactMap[_accountNumber] = contato.accountNumber;
    return db.insert(_table, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Contact> contacts = [];
    for (Map<String, dynamic> map in await db.query(_table)) {
      contacts.add(Contact(map[_id], map[_name], map[_accountNumber]));
    }
    return contacts;
  }
}

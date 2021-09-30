class Contact {
  final String name;
  final int accountNumber;
  final int id;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contato{name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'accountNumber': accountNumber};
}

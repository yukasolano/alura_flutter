import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {

  final Function(String password) onConfirm;

  AuthDialog({required this.onConfirm});

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Authorization"),
        content: TextField(
          controller: _passwordController,
            maxLength: 4,
            keyboardType: TextInputType.number,
            obscureText: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 64, letterSpacing: 24),
            decoration: InputDecoration(border: OutlineInputBorder())),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, child: Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                widget.onConfirm(_passwordController.text);
                Navigator.pop(context);
              }, child: Text("Confirm")),
        ]);
  }
}

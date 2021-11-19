import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String rotulo;
  final String? dica;
  final IconData? icone;
  final String? typeNumber;

  Editor(
      {required this.controller,
      required this.rotulo,
      this.dica,
      this.icone,
      this.typeNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType:
            typeNumber != null ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}

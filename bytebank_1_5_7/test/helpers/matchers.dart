import 'package:alura_flutter/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool findMiniCard(Widget widget, String title, IconData icon) {
  if (widget is MiniCard) {
    return widget.title == title && widget.icon == icon;
  }
  return false;
}


bool findLabel(Widget widget, String label) {
  if (widget is TextField) {
    return widget.decoration?.labelText == label;
  }
  return false;
}

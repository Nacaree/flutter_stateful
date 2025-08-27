import 'package:flutter/material.dart';

class ColorLogic extends ChangeNotifier {
  Color currentColor = Colors.blue;
  String colorName = "Blue";
  void setColor(Color newColor, String name) {
    currentColor = newColor;
    colorName = name;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class UiStateProvider extends ChangeNotifier {
  int _selectedMenu = 0;

  int get selectedMenu {
    return this._selectedMenu;
  }

  set selectedMenu(int i) {
    this._selectedMenu = i;
    notifyListeners(); // Necesitamos el EXTENDS de ChangeNotifier
  }
}

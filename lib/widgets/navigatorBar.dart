import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrmapurl/providers/uiState.dart';

class NavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // listen: false si estuviera dentro de un METODO
    final uiProvider = Provider.of<UiStateProvider>(context);
    final currentIndex = uiProvider.selectedMenu;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenu = i, // No es metodo es SETTER
      elevation: 0, // Quitar linea de sepación
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'URLs',
        ),
      ],
    );
  }
}

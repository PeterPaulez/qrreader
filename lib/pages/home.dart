import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrmapurl/pages/mapas_lista.dart';
import 'package:qrmapurl/pages/urls_lista.dart';
import 'package:qrmapurl/providers/scanList.dart';
import 'package:qrmapurl/providers/uiState.dart';
import 'package:qrmapurl/widgets/navigatorBar.dart';
import 'package:qrmapurl/widgets/scanBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial códigos QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              final scanListProvider = Provider.of<ScanListProvider>(
                context,
                listen: false,
              );
              scanListProvider.borrarTodos();
            },
          ),
        ],
      ),
      body: _HomeBody(),
      bottomNavigationBar: NavigatorBar(),
      floatingActionButton: ScanBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el acceso a nuestro provider que esta en MAIN.dart
    final uiProvider = Provider.of<UiStateProvider>(context);
    final currentIndex = uiProvider.selectedMenu;

    // Usar el provider Scans (No queremos redibujar aquí por eso el FALSE)
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      listen: false,
    );
    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        //return TilesList(tipo: 'geo');
        return MapasListaPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return URLsListaPage();
      default:
        return MapasListaPage();
    }
  }
}

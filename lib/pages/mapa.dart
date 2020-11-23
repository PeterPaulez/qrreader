import 'package:flutter/material.dart';
import 'package:qrmapurl/models/scan.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Coordenadas MAPS')),
      body: Center(child: Text('Home Page: ${scan.valor}')),
    );
  }
}

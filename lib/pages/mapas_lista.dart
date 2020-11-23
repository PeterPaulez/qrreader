import 'package:flutter/material.dart';
import 'package:qrmapurl/widgets/tilesList.dart';

class MapasListaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dentro de BUILD se redibuja, pero en funciones/metodos siempre FALSE
    return TilesList(tipo: 'geo');
  }
}

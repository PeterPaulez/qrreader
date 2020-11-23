import 'package:flutter/material.dart';
import 'package:qrmapurl/models/scan.dart';
import 'package:qrmapurl/providers/dbSQL.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBSqlProvider.db.nuevoScan(nuevoScan);
    // Asignar el ID de la BBDD al modelo guardado
    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      if (this.scans == null) {
        print('Scans is null');
        this.scans = [];
      }
      // Si es la misma pantalla actualizamos el listener
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBSqlProvider.db.getScansAll();
    this.scans = [...scans]; // Reemplazar con el nuevo listado
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBSqlProvider.db.getScansByTipo(tipo);
    this.scans = scans; // Reemplazar con el nuevo listado
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    final contador = await DBSqlProvider.db.borrarScansAll();
    print('Borrados: $contador');
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    final contador = await DBSqlProvider.db.borrarScanById(id);
    print('Borrado: $contador');
    //this.cargarScansPorTipo(this.tipoSeleccionado); // Lo quita el dissmisss
    //notifyListeners(); // Cargamos el notify en el cargador de Todo!
  }
}

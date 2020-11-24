import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrmapurl/providers/scanList.dart';
import 'package:qrmapurl/utils/utils.dart';

class ScanBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        elevation: 0, // Quitamos la sombra
        onPressed: () async {
          /*
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF',
            'Cancelar',
            false,
            ScanMode.QR,
          );
          */
          String barcodeScanRes = '';
          barcodeScanRes = 'geo:45.287135,-75.920226';
          //barcodeScanRes = 'https://profurgol.com';
          if (barcodeScanRes == '-1') {
            return; // Usuario ha dado al botón cancelar
          }

          final scanListProvider = Provider.of<ScanListProvider>(
            context,
            listen: false,
          );
          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
          print('Respuesta: $barcodeScanRes');
          launchURL(context, nuevoScan);
        },
        child: Icon(Icons.filter_center_focus),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrmapurl/providers/scanList.dart';
import 'package:qrmapurl/utils/utils.dart';

class TilesList extends StatelessWidget {
  final String tipo;
  const TilesList({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    if (scans != null) {
      return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) {
            print(direction);
            Provider.of<ScanListProvider>(context, listen: false)
                .borrarScanPorId(scans[i].id);
          },
          child: ListTile(
            leading: Icon(
              (this.tipo == 'http') ? Icons.map : Icons.map_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(scans[i].valor),
            subtitle: Text('ID: ${scans[i].id}'),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scans[i]),
          ),
        ),
      );
    } else {
      return Center(child: Text('Todavía no tienes Mapas'));
    }
  }
}

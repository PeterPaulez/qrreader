import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrmapurl/models/scan.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _tipoMapa = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition _puntoInicial = CameraPosition(
      //target: LatLng(37.42796133580664, -122.085749655962),
      target: scan.getLatLng(), //LatLng object
      zoom: 17.5,
      tilt: 50,
    );

    // Marcadores, creamos los marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas MAPS'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_disabled),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(_puntoInicial));
            },
          ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false, //Quitar el botón por defecto y crearlo
        mapType: _tipoMapa, // Tipos de mapas
        markers: markers,
        initialCameraPosition: _puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if (_tipoMapa == MapType.normal) {
            _tipoMapa = MapType.satellite;
          } else {
            _tipoMapa = MapType.normal;
          }
          setState(() {});
        },
      ),
    );
  }
}

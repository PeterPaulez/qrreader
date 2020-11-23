import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrmapurl/pages/home.dart';
import 'package:qrmapurl/pages/mapa.dart';
import 'package:qrmapurl/providers/scanList.dart';
import 'package:qrmapurl/providers/uiState.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiStateProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        title: 'QR Reader',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          // No se necesitas el buildcontext pero mandamos la referencia
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple,
            )),
      ),
    );
  }
}

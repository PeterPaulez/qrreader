import 'package:flutter/material.dart';
import 'package:qrmapurl/models/scan.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}

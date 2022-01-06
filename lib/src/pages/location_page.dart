import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String msjlocal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localización'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 46.0, color: Colors.blue),
            SizedBox(height: 10.0),
            Text('Obtener Localización',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Text(msjlocal),
            FlatButton(
              onPressed: () {
                askGpsAccess();
              },
              color: Colors.blue,
              child: Text(
                'Obtener ubicación actual',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void obtenerUbicacionActual() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    setState(() {
      msjlocal = '$position';
    });
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        obtenerUbicacionActual();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        _mostrarAlert(context);
        openAppSettings();
    }
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Permiso Denegado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Necesita activar los permisos de localización para poder continuar. Por favor, active los permisos en la configuración de la aplicación.'),
                FlutterLogo(size: 100.0)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}

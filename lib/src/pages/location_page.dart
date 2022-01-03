import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
              obtenerUbicacionActual();
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
        msjlocal ='$position';
     });
  }
}

import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Seleccione imagen'),
                Padding(padding: EdgeInsets.only(bottom: 8.0)),
              ],
            ),
            (imagePath == '')
                ? Container()
                : Image.file(File(imagePath), width: 400, height: 400),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            RaisedButton(
              child: Text('Cargar Imagen'),
              onPressed: _optionDialogBox,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _optionDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Elija opcion'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Padding(padding: EdgeInsets.only(right: 8.0)),
                      GestureDetector(
                        child: Text('Tomar Foto'),
                        onTap: () {
                          _openCamera(context);
                        },
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Row(
                    children: [
                      Icon(Icons.photo_album),
                      Padding(padding: EdgeInsets.only(right: 8.0)),
                      GestureDetector(
                        child: Text('Abrir Galeria'),
                        onTap: () {
                          _openGallery(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _openCamera(BuildContext context) async {
    PickedFile? picture =
        await ImagePicker().getImage(source: ImageSource.camera);

    
    if (picture?.path.isEmpty == null) {
        imagePath = '';
      } else {
        imagePath = picture!.path;
        final fileBytes = File(imagePath).readAsBytesSync();
        final data = await readExifFromBytes(fileBytes);
        for (final entry in data.entries) {
          if (entry.key == 'GPS GPSLatitude' || entry.key == 'GPS GPSLatitudeRef' || entry.key == 'GPS GPSLongitudeRef' ||  entry.key == ' GPS GPSLongitude') {
            print("${entry.key}: ${entry.value}");
          }
          print("${entry.key}: ${entry.value}");
        }
      }
    
    setState(() {});

    Navigator.of(context).pop();
  }

  Future<void> _openGallery(BuildContext context) async {
    PickedFile? picture =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (picture?.path.isEmpty == null) {
        imagePath = '';
      } else {
        imagePath = picture!.path;
        final fileBytes = File(imagePath).readAsBytesSync();
        final data = await readExifFromBytes(fileBytes);

        for (final entry in data.entries) {
          if (entry.key == 'GPS GPSLatitude' || entry.key == 'GPS GPSLatitudeRef' || entry.key == 'GPS GPSLongitudeRef' || entry.key == 'GPS GPSLongitude') {
            print("${entry.key}: ${entry.value}");
          }
          print("${entry.key}: ${entry.value}");
        }
      }
    
    setState(() {});
    
    Navigator.of(context).pop();
  }
}

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;

  getImageFile(ImageSource source) async {

     //Clicking or Picking from Gallery 

    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: source);

    //Cropping the image
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.teal,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );


    //Compress the image



    setState(() {
      _image = croppedFile;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Click n Crop"),
      ),
      body: Center(
        child: _image == null
            ? Text("Image")
            : Image.file(
                _image,
                height: 600,
                width: 600,
              ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            label: Text("Camera"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera_alt),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            label: Text("Gallery"),
            onPressed: () => getImageFile(ImageSource.gallery),
            heroTag: UniqueKey(),
            icon: Icon(Icons.photo_library),
          )
        ],
      ),
    );
  }
}

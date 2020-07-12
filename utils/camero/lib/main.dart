import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
void main() => runApp(MyApp());
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }

}

class MyAppState extends State<MyApp>{
   File _image;
   String paths;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      // ignore: deprecated_member_use
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else {
      // ignore: deprecated_member_use
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

    }
    setState(() {
      _image = image ;
      paths =  _image.path;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Pick'),
        ),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.insert_drive_file),
              onPressed: (){
                getImage(false);
              },
            ),
            SizedBox(height: 20.0,),
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: (){
                getImage(true);
                },
            ),
            FloatingActionButton(
              child: Text(
                'Display Image',
              ),
              onPressed: (){
                 Navigator.push(context, new MaterialPageRoute(builder: (context) => new ImagePreview(imagePath: this.paths,)));
              },
            )

          ],
        ),
      ),
      ),
    );
  }


  
}
class ImagePreview extends StatelessWidget {
  final String imagePath;
  const ImagePreview({Key key, this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display'),
        backgroundColor: Colors.black,
      ),
      body: (Image.file(File(imagePath))
      ),
    );

  }
}

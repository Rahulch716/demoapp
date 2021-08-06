import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick Image'),
        ),
        body: Container(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text('Please Pick an image', style: TextStyle(fontSize: 26)),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Select an Image",
                                    style: TextStyle(fontSize: 22)),
                                actions: [
                                  TextButton(
                                      child: Text("Gallery",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                      onPressed: () {
                                        galleryImage();
                                      }),
                                  TextButton(
                                      child: Text("Camera",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        cameraImage();
                                      })
                                ]);
                          });
                    },
                    child: Text("Pick Image"))
              ])),
        ));
  }
}

Future cameraImage() async {
  var cameraPhoto = await ImagePicker().pickImage(source: ImageSource.camera);
}

Future galleryImage() async {
  var galleryPhoto = await ImagePicker().pickImage(source: ImageSource.gallery);
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var photo;
var path;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick Image'),
        ),
        body: Container(
          child: Center(
              child: Column(children: [
            photo != null
                ? Image.file(
                    photo,
                    height: 400,
                    width: 400,
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
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
                                    Navigator.pop(context);
                                  }),
                              TextButton(
                                  child: Text("Camera",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    cameraImage();
                                    Navigator.pop(context);
                                  })
                            ]);
                      });
                },
                child: Text("Pick Image")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  post();
                },
                child: Text('Post'))
          ])),
        ));
  }

  final ImagePicker _picker = ImagePicker();

  Future cameraImage() async {
    final XFile? _cameraPhoto =
        await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      photo = File(_cameraPhoto!.path);
      path = _cameraPhoto.path;
    });
  }

  Future galleryImage() async {
    final XFile? _galleryPhoto =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      photo = File(_galleryPhoto!.path);
      path = _galleryPhoto.path;
    });
    print(_galleryPhoto!.path);
  }

  Future post() async {
    Response response;
    var dio = Dio();
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        path,
      )
    });

    response = await dio.post(
      'https://codelime.in/api/remind-app-token',
      data: formData,
    );
    print(response.statusCode.toString());
    setState(() {
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(response.data.toString()),
              );
            });
      }
    });
  }
}

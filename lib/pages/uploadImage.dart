import 'dart:io';

import 'package:auth/providers/learnProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadImage() {
    if (_image == null) return;
    Provider.of<LearnProvider>(context, listen: false).upload(_image.path);
  }

  @override
  Widget build(BuildContext context) {
    var provide = Provider.of<LearnProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: uploadImage,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.upload_file),
      ),
    );
  }
}

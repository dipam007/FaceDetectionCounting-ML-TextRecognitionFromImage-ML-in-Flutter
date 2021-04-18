import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Details.dart';

class TextRecognition extends StatefulWidget {
  @override
  _TextRecognitionState createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {

  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();

  String status='No Image Selected';

  @protected
  void initState() {
    _text = '';
    super.initState();
  }


  Future scanTxt() async{
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognition = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognition.processImage(visionImage);

    for(TextBlock block in visionText.blocks){
      for(TextLine line in block.lines){
        _text += line.text + '\n';
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Details(text: _text,)));
  }

  Future getImageFromGallary() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null){
        _image = pickedFile;
      }
      else{
        status = "Image is Not Selected";
      }
    });
  }

  Future getImageFromCamara() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile!=null){
        _image = pickedFile;
      }
      else{
        status = "Image is Not Selected";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Recognition"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: scanTxt,
              child: Text("Scan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image!=null
              ? Image.file(File(_image.path), fit: BoxFit.fitWidth,)
                : Center(child: Text(status),),
        ),
      ),
      persistentFooterButtons: [
        MaterialButton(
          height: 40,
          child: Icon(Icons.photo, color: Colors.blueAccent, size: 50,),
          onPressed: getImageFromGallary,
          minWidth: 60,
        ),
        MaterialButton(
          height: 40,
          child: Icon(Icons.add_a_photo, color: Colors.redAccent, size: 50,),
          onPressed: getImageFromCamara,
          minWidth: 60,
        ),
      ],
    );
  }
}

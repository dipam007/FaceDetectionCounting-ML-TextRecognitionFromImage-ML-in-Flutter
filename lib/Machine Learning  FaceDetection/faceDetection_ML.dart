import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui' as ui;

class FaceDetection extends StatefulWidget {
  @override
  _FaceDetectionState createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {

  File _imageFile;
  List<Face> _faces;
  bool isLoading = false;
  ui.Image _image;
  final picker = ImagePicker();
  int faceCount =0;

  _getImageCamara() async {
    final imageFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      isLoading = true;
    });

    final image = FirebaseVisionImage.fromFile(File(imageFile.path));
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      setState(() {
        _imageFile = File(imageFile.path);
        _faces = faces;
        _loadImage(File(imageFile.path));  //_loadImage is used for conver image into bytes so machine can understand
      });
    }
  }

  _getImageGallary() async {
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      isLoading = true;
    });

    final image = FirebaseVisionImage.fromFile(File(imageFile.path));
    final faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      setState(() {
        _imageFile = File(imageFile.path);
        _faces = faces;
        _loadImage(File(imageFile.path));  //_loadImage is used for conver image into bytes so machine can understand
      });
    }
  }

  _loadImage(File file) async{
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) => setState((){
      _setFaceCount();
      _image = value;
      isLoading = false;
    }));
  }

  _setFaceCount(){
    setState(() {
      faceCount = _faces.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(),)
        : Scaffold(
      appBar: AppBar(
        title: Text("Face Detection Machine Learning"),
      ),
      body: Center(
        child: FittedBox(
          child: _imageFile==null ? Center(child: Text("No Image Selected"),) : Container(
            width: _image.width.toDouble(),
            height: _image.height.toDouble(),
            child: CustomPaint(
              painter: FacePainter(_image, _faces),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          color: Colors.lightGreen,
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(left: 10, right: MediaQuery.of(context).size.width*0.4),
          child: Text(faceCount.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),),
        ),
        MaterialButton(
            height: 40,
            child: Icon(Icons.photo, color: Colors.blueAccent, size: 50,),
            onPressed: _getImageGallary,
            minWidth: 60,
        ),
        MaterialButton(
            height: 40,
            child: Icon(Icons.add_a_photo, color: Colors.redAccent, size: 50,),
            onPressed: _getImageCamara,
          minWidth: 60,
        ),
      ],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _getImageGallary,
      //   splashColor: Colors.lightGreen,
      //   backgroundColor: Colors.redAccent,
      //   tooltip: 'Pick Image',
      //   child: Icon(Icons.add_a_photo, size: 30,),
      //   foregroundColor: Colors.white,
      //   mini: false,
      //   highlightElevation: 10.0,
      //   elevation: 20.0,
      // ),
    );
  }
}

class FacePainter extends CustomPainter{
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces){
    for(var i=0;i<faces.length;i++){
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for(var i=0;i<faces.length;i++){
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter old) {
    // TODO: implement shouldRepaint
    return image != old.image || faces != old.faces;
  }


}
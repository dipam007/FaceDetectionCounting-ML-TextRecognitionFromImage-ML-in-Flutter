import 'package:flutter/material.dart';
import 'file:///C:/Users/aa/AndroidStudioProjects/flutter_machine_learning/lib/Machine%20Learning%20%20FaceDetection/faceDetection_ML.dart';
import 'package:flutter_machine_learning/Text%20Recognition%20From%20Image/TextRecognition.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(child: Center(child: Text("1) Face Detection in Machine Learning using Flutter", style: TextStyle(fontWeight: FontWeight.w800), )),),
          Container(
            child: IconButton(
              alignment: Alignment.center,
                iconSize: 80,
                icon: Icon(Icons.face, color: Colors.blueAccent,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FaceDetection()));
                }),
          ),
          SizedBox(child: Center(child: Text("1) Face Detection in Machine Learning using Flutter", style: TextStyle(fontWeight: FontWeight.w800), )),),
          Container(
            child: IconButton(
                alignment: Alignment.center,
                iconSize: 80,
                icon: Icon(Icons.text_fields, color: Colors.brown[400],),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TextRecognition()));
                }),
          )
        ],
      ),
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   File _imageFile;
//   List<Face> _faces;
//   bool isLoading = false;
//   ui.Image _image;
//   final picker = ImagePicker();
//
//   _getImage() async {
//     final imageFile = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       isLoading = true;
//     });
//
//     final image = FirebaseVisionImage.fromFile(File(imageFile.path));
//     final faceDetector = FirebaseVision.instance.faceDetector();
//     List<Face> faces = await faceDetector.processImage(image);
//
//     if (mounted) {
//       setState(() {
//         _imageFile = File(imageFile.path);
//         _faces = faces;
//         _loadImage(File(imageFile.path));  //_loadImage is used for conver image into bytes so machine can understand
//       });
//     }
//   }
//
//   _loadImage(File file) async{
//       final data = await file.readAsBytes();
//       await decodeImageFromList(data).then((value) => setState((){
//         _image = value;
//         isLoading = false;
//       }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading ? Center(child: CircularProgressIndicator(),)
//         : Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: FittedBox(
//           child: _imageFile==null ? Center(child: Text("No Image Selected"),) : SizedBox(
//             width: _image.width.toDouble(),
//             height: _image.height.toDouble(),
//             child: CustomPaint(
//               painter: FacePainter(_image, _faces),
//             ),
//           ),
//         ),
//       ),
//       // body: Center(
//       //   child: Column(
//       //     children: [
//       //       Container(
//       //         height: 100,
//       //         width: 120,
//       //         color: Colors.lightGreen,
//       //         child: RaisedButton(
//       //           onPressed: _getImage,
//       //           child: Text("Pick Image"),
//       //         ),
//       //       ),
//       //       Center(
//       //         child: FittedBox(
//       //           child: SizedBox(
//       //             width: 100.0,
//       //             height: 80.0,
//       //             child: CustomPaint(
//       //               painter: FacePainter(_image, _faces),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getImage,
//         backgroundColor: Colors.blueGrey,
//         tooltip: 'Pick Image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }
//
// class FacePainter extends CustomPainter{
//   final ui.Image image;
//   final List<Face> faces;
//   final List<Rect> rects = [];
//
//   FacePainter(this.image, this.faces){
//     for(var i=0;i<faces.length;i++){
//       rects.add(faces[i].boundingBox);
//     }
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     final Paint paint = Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 4.0
//         ..color = Colors.redAccent;
//
//     canvas.drawImage(image, Offset.zero, Paint());
//     for(var i=0;i<faces.length;i++){
//       canvas.drawRect(rects[i], paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(FacePainter old) {
//     // TODO: implement shouldRepaint
//     return image != old.image || faces != old.faces;
//   }
//
//
// }
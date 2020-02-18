import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera.dart';

List<CameraDescription> cameras;

void main() => runApp(app());

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(cameras),
    );
  }
}

class MyApp extends StatefulWidget {
  var cameras;
  MyApp(this.cameras);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          cameras = await availableCameras();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return camerascreen(cameras);
          }));
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_playground/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class camerascreen extends StatefulWidget {
  List<CameraDescription> cameras;

  camerascreen(this.cameras);

  @override
  _camerascreenState createState() => _camerascreenState();
}

class _camerascreenState extends State<camerascreen> {
  CameraController controller;
  var _timestamp = DatePickerDateTimeOrder.date_time_dayPeriod;

  void captureImage() async {
    if (controller.value.isInitialized) {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/media';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/$_timestamp.jpeg';
      await controller.takePicture(filePath);
      print('Image is Captured');
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    print(cameras);
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void switchCameras() {
      print('Cameras swithced');
      final CameraDescription cameraDescription =
          (controller.description == widget.cameras[0])
              ? widget.cameras[1]
              : widget.cameras[0];
      controller = CameraController(cameraDescription, ResolutionPreset.max,
          enableAudio: true);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }

    if (!controller.value.isInitialized) {
      return Container(
        color: Colors.blue,
      );
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: 110,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.55,
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              child: CameraPreview(controller),
              aspectRatio: 1.33,
            ),
          ),
        ),
        Positioned(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: switchCameras,
                child: Icon(
                  Icons.cached,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: switchCameras,
                child: Icon(
                  Icons.cached,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          bottom: MediaQuery.of(context).size.height - 100,
        ),
        Positioned(
          bottom: 70.0,
          left: MediaQuery.of(context).size.width * 0.5 - 35,
          child: GestureDetector(
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
            ),
            onTap: captureImage,
          ),
        )
      ],
    );
  }
}

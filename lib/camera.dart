import 'package:camera/camera.dart';
import 'package:camera_playground/main.dart';
import 'package:flutter/material.dart';

class camerascreen extends StatefulWidget {
  List<CameraDescription> cameras;

  camerascreen(this.cameras);

  @override
  _camerascreenState createState() => _camerascreenState();
}

class _camerascreenState extends State<camerascreen> {
  CameraController controller;

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
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        children: <Widget>[
          Container(
              child: CameraPreview(controller),
            height: 500,
          ),
          Positioned(
            child: GestureDetector(
              onTap: switchCameras,
              child: Icon(
                Icons.cached,
                size: 50.0,
                color: Colors.white,
              ),
            ),
            left: MediaQuery.of(context).size.width - 90,
            bottom: MediaQuery.of(context).size.height - 100,
          )
        ],
      ),
    );
  }
}

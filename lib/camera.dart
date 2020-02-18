import 'package:camera/camera.dart';
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
    controller = new CameraController(widget.cameras[0], ResolutionPreset.max);
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
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      title: 'Camera Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Demo')
        ),
        body: Center(
          child: Home()
        )
      )
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build (BuildContext context){
    return Scaffold(
        body: Center(
            child: TextButton(
              child: Text('Camera'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return Camera();
                })
                );
              },
            )
          )
    );
  }
}

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera Demo'),
          actions: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
              Navigator.pop(context);
            })
          ]
        ),
        body: CameraPreview(controller),
      )
    );
  }
}
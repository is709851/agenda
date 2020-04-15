import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      //theme: ThemeData.dark(),
      home: NotaCamera(
        camera: firstCamera,
      ),
    ),
  );
}

class NotaCamera extends StatefulWidget {
  final CameraDescription camera;

  NotaCamera({Key key, this.camera}) : super(key: key);

  @override
  _NotaCameraState createState() => _NotaCameraState();
}

class _NotaCameraState extends State<NotaCamera> {
  CameraController _controllerCamera;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  var ImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controllerCamera = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controllerCamera.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _controllerCamera?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controllerCamera != null
          ? _initializeControllerFuture = _controllerCamera.initialize()
          : null; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Nota camera'),
        ),
        backgroundColor: Color(0xFF042434),
      ),
      body: Container(
          
         child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Transform.scale(
                scale: _controllerCamera.value.aspectRatio, 
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controllerCamera.value.aspectRatio,
                    child: CameraPreview(_controllerCamera), 
                  ),
                ));
          } else {
            return Center(
                child:
                    CircularProgressIndicator()); 
          }
        },
      ),),
      floatingActionButton: 
      Container(
        color: Colors.transparent,
        width: 380,
        height: 80,
        child:FloatingActionButton(
          backgroundColor: Color(0xFF042434),
        child: Icon(Icons.camera_alt, size: 40,),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controllerCamera.takePicture(path);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        ),
      ),
    );
  }

  TextEditingController nota = new TextEditingController();
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,
              content: new Column(children: <Widget>[
                Container(
                  width: 300,
                  height: 500,
                  color: Colors.pinkAccent,
                  child: TextField(
                    maxLines: 50,
                    maxLength: 500,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ]));
        });
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foto')),
      body: Image.file(File(imagePath)),
    );
  }
}

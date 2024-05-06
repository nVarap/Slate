import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Slate',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 149, 207, 210),
            body: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.jpg'),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: ElevatedButton(
                        onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const SecondPage(title: "Scanning Page"))
                        );
                      },
                      child: Text(
                        "Start Scanning",
                        style: TextStyle(fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                    ))),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(30, 150, 10, 10),
                        child: Container(
                          width: 44.0,
                          height: 44.0,
                          child: Image.asset(
                            'assets/images/caution.png',
                            width: 50,
                            height: 50,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 150, 10, 10),
                        child: Container(
                          child: Text(
                              "If you are currently facing any serious symptoms \n such as loss of breath, loss of sense, \n or are falling unconcious, call 911 immediately"),
                        )),
                  ],
                )
              ],
            ))));
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 149, 207, 210),
        body: Center(
          
        )
      )
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({
    super.key,
    required this.camera,
    });

  final CameraDescription camera;

  @override
  CameraPageState createState() => CameraPageState();

}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState(){
    super.initState();
    _controller = CameraController(
      widget.camera, 
      ResolutionPreset.medium
      );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext){
    return Scaffold(appBar: AppBar(title: const Text("Picture Time!")),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_controller);
          } else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();

            if(!context.mounted) return; 

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                )
              )
            );
          } catch(e){
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      )
    );
    
  }


}


class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}

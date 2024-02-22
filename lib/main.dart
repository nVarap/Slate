import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slate',
      home: const MyHomePage(title: 'Slate Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

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
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))));
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

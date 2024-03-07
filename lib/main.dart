import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:react_flutter/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('React + Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FlutterCounterApp(
                                title: "Flutter Counter",
                              )));
                },
                child: const Text('Flutter Counter App'),
              ),
              TextButton(
                onPressed: () async {
                  await const MethodChannel("com.example.react_flutter/channel")
                      .invokeMethod("react", {});
                },
                child: const Text('React Counter App'),
              ),
            ],
          ),
        ));
  }
}

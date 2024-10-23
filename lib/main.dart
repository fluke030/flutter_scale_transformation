import 'package:flutter/material.dart';
import 'package:resolution_transformation/presentation/widgets/image_box.dart';
import 'package:resolution_transformation/transformations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resolution Transformation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Resolution Transformation Demo'),
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
  final List<Offset> _points = [];
  static const Offset defaultBox = Offset(640, 320);

  void _addPoint(Offset point, double width, double height) {
    setState(() {
      final Offset newPoint = Transformations.transformPoint(
          point, Offset(width, height), defaultBox);
      _points.add(newPoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageBox(
                    targetBox: defaultBox,
                    points: _points,
                    defaultBox: defaultBox,
                    addPointCallback: _addPoint),
                ImageBox(
                    targetBox: const Offset(360, 480),
                    points: _points,
                    defaultBox: defaultBox,
                    addPointCallback: _addPoint)
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ImageBox(
                  targetBox: const Offset(1000, 240),
                  points: _points,
                  defaultBox: defaultBox,
                  addPointCallback: _addPoint),
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _points.clear();
            });
          },
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          child: const Icon(Icons.clear)),
    );
  }
}

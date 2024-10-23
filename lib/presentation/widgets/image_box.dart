import 'package:flutter/material.dart';
import 'package:resolution_transformation/transformations.dart';

class ImageBox extends StatefulWidget {
  final Offset targetBox;
  final Offset defaultBox;
  final List<Offset> points;
  final Function(Offset point, double width, double height) addPointCallback;

  void addPoint(Offset point) {
    addPointCallback(point, targetBox.dx, targetBox.dy);
  }

  const ImageBox(
      {super.key,
      required this.targetBox,
      required this.points,
      required this.defaultBox,
      required this.addPointCallback});

  @override
  State<ImageBox> createState() => _ImageBox();
}

class _ImageBox extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    LinePainter canvasPainter = LinePainter(
        points: widget.points,
        defaultBox: widget.defaultBox,
        targetBox: widget.targetBox);
    return Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            widget.addPoint(details.localPosition);
          },
          child: Stack(
            children: [
              SizedBox(
                  width: widget.targetBox.dx,
                  height: widget.targetBox.dy,
                  child: Image.asset("assets/images/parking_lot.jpg",
                      fit: BoxFit.fill)),
              Text(
                  "${widget.targetBox.dx.truncate()}x${widget.targetBox.dy.truncate()}",
                  style: const TextStyle(color: Colors.yellow)),
              CustomPaint(painter: canvasPainter)
            ],
          ),
        ));
  }
}

class LinePainter extends CustomPainter {
  List<Offset> points;
  Offset defaultBox;
  Offset targetBox;
  // final image = Image.asset("assets/images/parking_lot.jpg", fit: BoxFit.fill);

  LinePainter({
    required this.points,
    required this.defaultBox,
    required this.targetBox,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawImage(image, Offset.zero, Paint());

    if (points.length >= 2) {
      final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0;

      for (var i = 0; i < points.length - 1; i++) {
        final transformP0 =
            Transformations.transformPoint(points[i], defaultBox, targetBox);
        final transformP1 = Transformations.transformPoint(
            points[i + 1], defaultBox, targetBox);
        canvas.drawLine(transformP0, transformP1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

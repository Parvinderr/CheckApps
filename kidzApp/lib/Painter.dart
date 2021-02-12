import 'package:flutter/material.dart';
import 'package:kidzApp/colorPallete.dart';

class Signature extends StatefulWidget {
  final double height;
  final String title;
  final double width;
  Signature({
    this.height,
    this.width,
    this.title,
  });
  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];
  var color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[500],
        title: Text(
          widget.title,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(
              30,
              40,
            ),
            bottomRight: Radius.elliptical(
              30,
              40,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            semanticLabel: 'Back',
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.palette,
              semanticLabel: 'Pallete',
            ),
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Pallete(),
                ),
              );
              setState(() {
                color = result;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.cleaning_services,
              semanticLabel: 'Eraser',
            ),
            onPressed: () {
              setState(() {
                _points = List<Offset>.empty();
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(
              () {
                RenderBox object = context.findRenderObject();
                Offset _localPosition =
                    object.globalToLocal(details.globalPosition);
                _points = List.from(_points)..add(_localPosition);
              },
            );
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: CustomPaint(
            painter: SignaturePainter(
              points: _points,
              colors: color,
            ),
          ),
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  List<Offset> points;
  final Color colors;

  SignaturePainter({
    this.points,
    this.colors = Colors.black,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colors
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.5;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}

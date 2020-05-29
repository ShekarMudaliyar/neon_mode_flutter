import 'dart:io';
import 'package:flutter/material.dart';

class FlickerCircle extends StatefulWidget {
  final Color color;
  final double radius;
  final bool shouldFlicker;
  final int shadowSpread;
  final double strokeWidth;
  final int spreadValue;
  final Widget child;
  const FlickerCircle(
      {Key key,
      this.color,
      this.radius,
      this.shouldFlicker,
      this.shadowSpread,
      this.strokeWidth,
      this.spreadValue,
      this.child})
      : super(key: key);
  @override
  _FlickerCircleState createState() => _FlickerCircleState();
}

class _FlickerCircleState extends State<FlickerCircle>
    with TickerProviderStateMixin {
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _fadeInFadeOut = Tween<double>(begin: 1.0, end: 0.2).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        sleep(Duration(milliseconds: 200));
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.shouldFlicker
          ? FadeTransition(
              opacity: _fadeInFadeOut,
              child: Container(
                child: CustomPaint(
                  painter: ShapePainter(
                    color: widget.color,
                    radius: widget.radius,
                    shadowSpread: widget.shadowSpread,
                    strokeWidth: widget.strokeWidth,
                    spreadValue: widget.spreadValue,
                  ),
                  child: widget.child == null ? Container() : widget.child,
                ),
              ),
            )
          : Container(
              child: CustomPaint(
                painter: ShapePainter(
                  color: widget.color,
                  radius: widget.radius,
                  shadowSpread: widget.shadowSpread,
                  strokeWidth: widget.strokeWidth,
                  spreadValue: widget.spreadValue,
                ),
                child: widget.child == null ? Container() : widget.child,
              ),
            ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final Color color;
  final double radius;
  final int shadowSpread;
  final double strokeWidth;
  final int spreadValue;
  ShapePainter(
      {this.strokeWidth,
      this.radius,
      this.color,
      this.shadowSpread,
      this.spreadValue});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    List shadows = [];
    for (var i = 1; i <= shadowSpread; i++) {
      var shadow = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(
            BlurStyle.outer, convertRadiusToSigma((i * spreadValue).toDouble()))
        ..strokeCap = StrokeCap.round;
      shadows.add(shadow);
    }

    var stroke = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    shadows.forEach((element) {
      canvas.drawCircle(center, radius, element);
    });
    canvas.drawCircle(center, radius, stroke);
    canvas.drawCircle(center, radius, paint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

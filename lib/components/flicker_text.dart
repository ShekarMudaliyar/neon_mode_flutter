import 'dart:io';
import 'package:flutter/material.dart';

class FlickerText extends StatefulWidget {
  final Color color;

  const FlickerText({Key key, this.color}) : super(key: key);
  @override
  _FlickerTextState createState() => _FlickerTextState();
}

class _FlickerTextState extends State<FlickerText>
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
    TextStyle strokeStyle = TextStyle(
      letterSpacing: 5,
      fontSize: 50,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = widget.color,
      fontFamily: "NeonLights",
    );
    TextStyle glowStyle = TextStyle(
      letterSpacing: 5,
      fontSize: 50,
      shadows: [
        BoxShadow(
          color: widget.color,
          blurRadius: 1.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: widget.color,
          blurRadius: 30.0,
          spreadRadius: 30.0,
        ),
        BoxShadow(
          color: widget.color,
          blurRadius: 30.0,
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: widget.color,
          blurRadius: 200.0,
          spreadRadius: 200.0,
        ),
      ],
      color: Colors.white,
      fontFamily: "NeonLights",
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Text("Hello Wo", textAlign: TextAlign.center, style: strokeStyle),
            Text("Hello Wo", textAlign: TextAlign.center, style: glowStyle),
          ],
        ),
        FadeTransition(
          opacity: _fadeInFadeOut,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text("r", textAlign: TextAlign.center, style: strokeStyle),
              Text("r", textAlign: TextAlign.center, style: glowStyle),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Text("ld!", textAlign: TextAlign.center, style: strokeStyle),
            Text("ld!", textAlign: TextAlign.center, style: glowStyle),
          ],
        ),
      ],
    );
  }
}

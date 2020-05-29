import 'dart:io';
import 'package:flutter/material.dart';

class FlickerLine extends StatefulWidget {
  final Color color;

  const FlickerLine({Key key, this.color}) : super(key: key);
  @override
  _FlickerLineState createState() => _FlickerLineState();
}

class _FlickerLineState extends State<FlickerLine>
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
      child: FadeTransition(
        opacity: _fadeInFadeOut,
        child: Container(
          height: 5,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color,
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: widget.color,
                blurRadius: 100.0,
                spreadRadius: 15.0,
              ),
              BoxShadow(
                color: widget.color,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

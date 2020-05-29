import 'package:flutter/material.dart';
import 'package:neon_mode/components/flicker_circle.dart';
import 'package:neon_mode/components/flicker_line.dart';
import 'package:neon_mode/components/flicker_text.dart';
import 'package:neon_mode/components/single_flicker_text.dart';
import 'package:neon_mode/config/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Color primary = AppColors.neonNew;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(padding: const EdgeInsets.all(10)),
            SingleFlickerText(color: primary),
            Padding(padding: const EdgeInsets.all(50)),
            FlickerLine(color: primary),
            Padding(padding: const EdgeInsets.all(100)),
            FlickerCircle(
              color: primary,
              radius: 70,
              shouldFlicker: true,
              shadowSpread: 6,
              strokeWidth: 5,
              spreadValue: 10,
            ),
            Padding(padding: const EdgeInsets.all(100)),
            FlickerCircle(
              color: primary,
              radius: 70,
              shouldFlicker: false,
              shadowSpread: 5,
              strokeWidth: 3,
              spreadValue: 5,
              child: FlickerText(
                color: primary,
                text: "click",
                shouldFlicker: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

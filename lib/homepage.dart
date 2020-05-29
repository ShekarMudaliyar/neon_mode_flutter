import 'package:flutter/material.dart';
import 'package:neon_mode/components/flicker_circle.dart';
import 'package:neon_mode/components/flicker_line.dart';
import 'package:neon_mode/components/flicker_text.dart';
import 'package:neon_mode/config/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            FlickerText(color: AppColors.neonNew),
            Padding(padding: const EdgeInsets.all(50)),
            FlickerLine(color: AppColors.neonNew),
            Padding(padding: const EdgeInsets.all(100)),
            FlickerCircle(color: AppColors.neonNew),
          ],
        ),
      ),
    );
  }
}

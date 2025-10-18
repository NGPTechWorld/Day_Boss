import 'package:flutter/material.dart';
import 'package:awesome_calendart/awesome_calendart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AwesomeCalenDart(eventMarkers: [DateTime(2025,)]),
          ],
        ),
      ),
    );
  }
}

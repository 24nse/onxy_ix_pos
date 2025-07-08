import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/presentation/modules/home/view/home_screen.dart';

void main() {
  runApp(const OnyxIxPosApp());
}

class OnyxIxPosApp extends StatelessWidget {
  const OnyxIxPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
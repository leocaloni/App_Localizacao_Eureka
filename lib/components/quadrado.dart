import 'package:flutter/material.dart';

class Quadrado extends StatelessWidget {
  final String imagePath;

  const Quadrado({super.key,
  required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white),
        child: Image.asset(imagePath, height: 35,),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movegui/screens/resto_screen.dart';

class DeveliveryScreen extends StatelessWidget{
  const DeveliveryScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(Object context) {
    return RestoScreen();
  }
}
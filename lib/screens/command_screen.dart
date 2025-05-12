

import 'package:flutter/material.dart';
import 'package:movegui/screens/resto_screen.dart';

class Commandscreen extends StatelessWidget {
  const Commandscreen({super.key, required this.title});
  final String title;

  @override
  Widget build(Object context) {
    return RestoScreen();
  }
  
}

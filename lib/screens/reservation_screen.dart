
import 'package:flutter/material.dart';
import 'package:movegui/screens/resto_screen.dart';

class ReservationScreen extends StatelessWidget{
  const ReservationScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return RestoScreen();
  }
}
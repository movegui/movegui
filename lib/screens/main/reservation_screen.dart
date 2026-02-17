
import 'package:flutter/material.dart';
import 'package:movegui/screens/categories/resto_screen.dart';

class ReservationScreen extends StatelessWidget{
  const ReservationScreen({super.key, required this.title, required this.navigatorKey});
  final String title;
    final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return RestoScreen(navigatorKey: navigatorKey,);
  }
}
import 'package:flutter/material.dart';
import 'package:movegui/widgets/app/app_footer_web.dart';
import 'package:movegui/widgets/web/menu_bar_web.dart';

class WebLayout extends StatelessWidget {
  final Widget child;

  const WebLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuBarWeb(),
      body: child,
      bottomNavigationBar: AppFooterWeb(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class ValidationButton extends StatelessWidget {
  final Future<void> Function(BuildContext context, ButtonItem item) fn;
  final ButtonItem buttonItem;
  final IconData? icon;

  const ValidationButton({super.key, required this.fn, required this.buttonItem, this.icon, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ButtonWidget(onPressed: fn, buttonItem: buttonItem, icon: IconlyLight.send)
            
          ),
        ),
      ],
    );
  }
}

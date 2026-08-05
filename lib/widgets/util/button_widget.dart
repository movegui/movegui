
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/models/button_item.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonItem buttonItem;
  final IconData? icon;
  final Color? selectionColor;
  final double? padding;
  final Future<void> Function(BuildContext context, ButtonItem item)? onPressed;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonItem,
    required this.icon,
    this.padding = 3.0,
    this.selectionColor = AppColors.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(padding!)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
      icon:
          icon != null
              ? Icon(icon!,)
              : const SizedBox(),
      label: Text(buttonItem.title!,),
      onPressed: () async {
          if(buttonItem.enabled){
             await onPressed!(context, buttonItem);
          }

      },
    
    );
  }
}

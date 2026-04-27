
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/models/button_item.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonItem buttonItem;
  final IconData? icon;
  final Color? backgroundColor;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final Future<void> Function(BuildContext context, ButtonItem item) onPressed;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonItem,
    required this.icon,
    this.backgroundColor,
    this.fontStyle,
    this.textDecoration,
    this.fontSize = 14.0
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
       // padding: const EdgeInsets.all(12.0),
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      icon:
          icon != null
              ? Icon(icon!,  color: AppColors.textColor,)
              : const SizedBox(), 
      label: Text(
        buttonItem.title!,
        style: TextStyle(color: AppColors.textColor, fontSize: fontSize),
      ),

      onPressed: () async {
        await onPressed(context, buttonItem);
      },
    );
  }
}

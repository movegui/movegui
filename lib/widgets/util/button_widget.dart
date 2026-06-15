
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/models/button_item.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonItem buttonItem;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectionColor;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final double? padding;
  final Future<void> Function(BuildContext context, ButtonItem item)? onPressed;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonItem,
    required this.icon,
    this.backgroundColor = AppColors.backgroundColor,
    this.fontStyle,
    this.textDecoration,
    this.fontSize = 14.0,
    this.padding = 3.0,
    this.textColor = AppColors.textColor,
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
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return selectionColor!; // hover color
          }
          if (states.contains(WidgetState.pressed)) {
            return selectionColor!;
          }
          return backgroundColor!;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return textColor!;
          }
          return textColor!;
        }),
      ),
      icon:
          icon != null
              ? Icon(icon!, color: textColor!)
              : const SizedBox(),
      label: Text(buttonItem.title!, style: TextStyle(fontSize: fontSize)),
      onPressed: () async {
          await onPressed!(context, buttonItem);
      },
    
    );
  }
}

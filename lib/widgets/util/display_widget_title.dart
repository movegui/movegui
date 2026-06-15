import 'package:flutter/widgets.dart';
import 'package:movegui/consts/app_colors.dart';


class DisplayWidgetTitle extends StatelessWidget {
  const DisplayWidgetTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 18.0,
     this.textColor = AppColors.textColor,
  });
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
        text ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:movegui/consts/app_colors.dart';


class DisplayWidgetTitle extends StatelessWidget {
  const DisplayWidgetTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.fontSize = 18.0,
     this.textColor = AppColors.textColor,
     this.backgroundColor = AppColors.backgroundColor,
     this.fontWeight = FontWeight.bold
  });
  final String? text;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? textColor;
  final Color? backgroundColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
        text ?? '',
        style: TextStyle(
          fontWeight: fontWeight,
          color: textColor,
          fontSize: fontSize,
          backgroundColor: backgroundColor!
        ),
        textAlign: textAlign,
    );
  }
}

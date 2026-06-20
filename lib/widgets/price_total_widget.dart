import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/widgets/util/display_widget_title.dart';

class PriceTotalWidget extends StatelessWidget {
  final String currency;
  final String? title;
  final double? total;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? backgroundColor;


  const PriceTotalWidget({
    super.key,
    required this.currency,
    this.title = 'TOTAL',
    required this.total,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.textColor = AppColors.textColor,
    this.backgroundColor = AppColors.backgroundColor,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: DisplayWidgetTitle(
              text: title,
              textAlign: TextAlign.left,
              textColor: textColor,
              fontSize: fontSize,
              backgroundColor: backgroundColor,
              fontWeight: fontWeight,
            ),
          ),
          Expanded(
            flex: 2,
            child: DisplayWidgetTitle(
              text: '$total $currency',
              textAlign: TextAlign.end,
              textColor: textColor,
              fontSize: fontSize,
              backgroundColor: backgroundColor,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}

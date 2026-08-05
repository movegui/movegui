import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class ValidationButton extends StatelessWidget {
  final Future<void> Function(BuildContext context, ButtonItem item) fn;
  final ButtonItem buttonItem;
  final IconData? icon;
  final double? padding;
  final Color? selectionColor;

  const ValidationButton({
    super.key,
    required this.fn,
    required this.buttonItem,
    this.icon = IconlyLight.send,
    this.padding = 3.0,
    this.selectionColor = AppColors.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          child: Center(
            child: SizedBox(
              width:
                  double
                      .infinity, //Responsive.isMobile(context) ? _size.width * 0.5 : 300,
              child: ButtonWidget(
                onPressed: fn,
                buttonItem: buttonItem,
                icon: icon,
                padding: padding,
                selectionColor:
                    buttonItem.enabled
                        ? selectionColor
                        : AppColors.placeHolderText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

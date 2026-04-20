import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/widgets/subtitle_text.dart';

class ButtonWidget extends StatefulWidget {
  final ButtonItem buttonItem;
  final IconData? icon;
  final Color? backgroundColor;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final Future<void> Function(BuildContext context, ButtonItem item) onPressed;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonItem,
    required this.icon,
    this.backgroundColor,
    this.fontStyle,
    this.textDecoration,
  });
  @override
  State<StatefulWidget> createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WidgetConstants.sepWidgetHeight * 0.5),
      child: ElevatedButton.icon(
        onHover:
            (value) => {
              if (value)
                {
                  setState(() {
                    _isHover = value;
                  }),
                }
              else
                {
                  setState(() {
                    _isHover = false;
                  }),
                },
            },
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(
            _isHover ? AppColors.selectionColor : AppColors.textColor,
          ),
          backgroundColor: WidgetStateProperty.all(AppColors.backgroundColor),
          padding: WidgetStateProperty.all(const EdgeInsets.all(WidgetConstants.sepWidgetHeight)),
          elevation: WidgetStateProperty.all(1),
          /*
          shape: WidgetStateProperty.all(
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          ),
          */
        ),
        icon:
            widget.icon != null
                ? Icon(
                  widget.icon!,
                  size:
                      _isHover
                          ? widget.buttonItem.fontSize *
                              WidgetConstants.buttonFontSizeZoomFactor
                          : widget.buttonItem.fontSize,
                )
                : const SizedBox(),
        label: Tooltip(
          message: widget.buttonItem.tooltipText,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SubtitleTextWidget(
            label: widget.buttonItem.title!,
            fontSize:
                _isHover
                    ? widget.buttonItem.fontSize *
                        WidgetConstants.buttonFontSizeZoomFactor
                    : widget.buttonItem.fontSize,
            fontStyle: widget.fontStyle ?? FontStyle.normal,
            textDecoration: widget.textDecoration ?? TextDecoration.none,
          ),
        ),
      
        onPressed: () async {
          await widget.onPressed(context, widget.buttonItem);
        },
      ),
    );
  }
}

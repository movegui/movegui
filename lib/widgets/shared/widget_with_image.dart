import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/home/home_image_widget.dart';

class WidgetWithImage extends ImageWidget {
  const WidgetWithImage({
    super.key,
    required super.title,
    required super.imagePath,
    required super.action,
    required super.routeName,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () => action(context, routeName, title, enabled),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const RoundedRectangleBorder(),
          backgroundColor: AppColors.textColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: Responsive.isDesktop(context) ? 210 : 120,
              width: double.infinity,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),

            Container(
              color: const Color(0xFF871A1C),
              padding: const EdgeInsets.symmetric(
                vertical: WidgetConstants.sepWidget,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Container(
              color: AppColors.textColor,
              padding: const EdgeInsets.symmetric(
                vertical: WidgetConstants.sepWidget,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (enabled) ...[
                    Container(
                      width: WidgetConstants.sepWidgetHeight,
                      height: WidgetConstants.sepWidgetHeight,
                      decoration: const BoxDecoration(
                        color: AppColors.activeColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: WidgetConstants.sepWidget),
                    Flexible(
                      // 👈 prevents text overflow
                      child: Text(
                        AppLocalizations.of(
                          context,
                        )!.activate_button_attach_message,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColors.activeColor,),
                      ),
                    ),
                  ] else ...[
                    Flexible(
                      child: Text(
                        AppLocalizations.of(
                          context,
                        )!.deactivate_button_attach_message,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColors.placeHolderText),
                        
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';

class RestoSubCategoryScreen extends StatelessWidget {
  const RestoSubCategoryScreen({super.key,
   // required this.navigatorKey
   });
  // final GlobalKey<NavigatorState> navigatorKey;

  void _onPressedImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
  //  final GlobalKey<NavigatorState>? navigatorkey
  ) {
    if (enabled)
    /*
      if(navigatorkey != null)
        navigatorkey.currentState?.pushNamed(routeName);
      else 
      */
        Navigator.pushNamed(context, routeName);
    else
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetWithImage(
              title: 'Pizza',
              routeName: '',
              imagePath: AssetsManager.category1Image,
              action: _onPressedImage,
              enabled: false,
            //  navigatorkey: null,
            ),
            WidgetWithImage(
              title: 'Burger',
              routeName: '',
              imagePath: AssetsManager.fast_food,
              action: _onPressedImage,
              enabled: false,
             // navigatorkey: null,
            ),
            WidgetWithImage(
              title: 'Sandwisch',
              routeName: '',
              imagePath: AssetsManager.category3Image,
              action: _onPressedImage,
              enabled: false,
            //  navigatorkey: null,
            ),
            WidgetWithImage(
              title: 'Vegan',
              routeName: '',
              imagePath: AssetsManager.category4Image,
              action: _onPressedImage,
              enabled: false,
            //  navigatorkey: null,
            ),
            WidgetWithImage(
              title: 'BBQ',
              routeName: '',
              imagePath: AssetsManager.category5Image,
              action: _onPressedImage,
              enabled: false,
           //   navigatorkey: null,
            ),
          ],
        ),
      ),
    );
  }
}

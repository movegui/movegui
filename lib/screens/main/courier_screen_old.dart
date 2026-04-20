import 'package:another_flushbar/flushbar.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';

class CourierScreen extends StatefulWidget {
  const CourierScreen({
    super.key,
    required this.onTitleChange,
  //  required this.navigatorKey,
  });
  final Function(String) onTitleChange;
 // final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<StatefulWidget> createState() => CourierScreenState();
}

class CourierScreenState extends State<CourierScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.courseTitle);
    });
  }

  void _onPressedImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
 //   final GlobalKey<NavigatorState>? navigatorkey,
  ) {
   // print('the navi is $navigatorkey, route is : $routeName');
    if (enabled)
    /*
      if (navigatorkey != null)
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
    return DynamicHeightGridView(
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      builder: (context, index) {
        return WidgetWithImage(
          title:
              AppConstants.coursesCategoriesItems(
                AppLocalizations.of(context)!,
              )[index].name,
          imagePath:
              AppConstants.coursesCategoriesItems(
                AppLocalizations.of(context)!,
              )[index].imageUrl,
          action: _onPressedImage,
          routeName:
              AppConstants.coursesCategoriesItems(
                AppLocalizations.of(context)!,
              )[index].routeName,
          enabled:
              AppConstants.coursesCategoriesItems(
                AppLocalizations.of(context)!,
              )[index].enabled,
        //  navigatorkey: widget.navigatorKey,
        );
      },
      itemCount:
          AppConstants.coursesCategoriesItems(
            AppLocalizations.of(context)!,
          ).length,
      crossAxisCount: 2,
    );
  }
}

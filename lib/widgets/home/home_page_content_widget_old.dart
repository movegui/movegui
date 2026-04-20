import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/home/home_image_widget.dart';

class HomePageContentOldWidget extends StatelessWidget {
  const HomePageContentOldWidget({super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWidget(
                    title: TitleManager.moveguiTitle,
                    routeName: '/home/movegui',
                    imagePath: AssetsManager.moveguiIcon,
                    action:
                        (context, routeName, title, enabled) =>
                            onAction(context, routeName, enabled),
                    enabled: true,
                  //  navigatorkey: navigatorKey,
                  ),

                  ImageWidget(
                    title: AppLocalizations.of(context)!.,
                    routeName: '/command',
                    imagePath: AssetsManager.commandeIcon,
                    action:
                        (context, routeName, title, enabled,) =>
                            onAction(context, routeName, enabled),
                    enabled: false,
                  //  navigatorkey: navigatorKey,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWidget(
                    title: TitleManager.livraisonTitle,
                    routeName: '/delivery',
                    imagePath: AssetsManager.livraisonIcon,
                    action:
                        (context, routeName, title, enabled,) =>
                            onAction(context, routeName, enabled),
                    enabled: false,
                 //   navigatorkey: navigatorKey,
                  ),
                  ImageWidget(
                    title: TitleManager.courseTitle,
                    routeName: '/courses',
                    imagePath: AssetsManager.courseIcon,
                    action:
                        (context, routeName, title, enabled,) =>
                            onAction(context, routeName, enabled),
                    enabled: true,
                 //   navigatorkey: navigatorKey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAction(
    BuildContext context,
    String routeName,
    bool enabled,
  ) {
    if (enabled)
     Navigator.of(context).pushNamed(routeName);
    else
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/home/home_image_widget.dart';

class HomePageContentWidget extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const HomePageContentWidget({super.key, required this.navigatorKey});

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
                            onAction(context, navigatorKey, routeName, enabled),
                    enabled: true,
                  ),

                  ImageWidget(
                    title: TitleManager.commandTitle,
                    routeName: '/command',
                    imagePath: AssetsManager.commandeIcon,
                    action:
                        (context, routeName, title, enabled) =>
                            onAction(context, navigatorKey, routeName, enabled),
                    enabled: false,
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
                        (context, routeName, title, enabled) =>
                            onAction(context, navigatorKey, routeName, enabled),
                    enabled: false,
                  ),
                  ImageWidget(
                    title: TitleManager.courseTitle,
                    routeName: '/courses',
                    imagePath: AssetsManager.courseIcon,
                    action:
                        (context, routeName, title, enabled) =>
                            onAction(context, navigatorKey, routeName, enabled),
                    enabled: true,
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
    GlobalKey<NavigatorState> navigatorKey,
    String routeName,
    bool enabled,
  ) {
    if (enabled)
      navigatorKey.currentState?.pushNamed(routeName);
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

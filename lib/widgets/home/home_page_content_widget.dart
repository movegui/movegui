import 'package:flutter/material.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/services/title_manager.dart';
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
                    action: (context, routeName, title) {
                      navigatorKey.currentState?.pushNamed(routeName);
                    },
                  ),

                  ImageWidget(
                    title: TitleManager.commandTitle,
                    routeName: '/command',
                    imagePath: AssetsManager.commandeIcon,
                    action: (context, routeName, title) {
                      navigatorKey.currentState?.pushNamed(routeName);
                    },
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
                    action: (context, routeName, title) {
                      navigatorKey.currentState?.pushNamed(routeName);
                    },
                  ),
                  ImageWidget(
                    title: TitleManager.courseTitle,
                    routeName: '/courses',
                    imagePath: AssetsManager.courseIcon,
                    action: (context, routeName, title) {
                      navigatorKey.currentState?.pushNamed(routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

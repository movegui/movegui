import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/categories_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';

class HomePageContentWidget extends StatefulWidget {
  const HomePageContentWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomePageContentWidgetState();
}

class HomePageContentWidgetState extends State<HomePageContentWidget> {
  late CategoriesService categoriesService;

  @override
  void initState() {
    categoriesService = getIt<CategoriesService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final item =
            AppConstants.allCategoriesItems(
              AppLocalizations.of(context)!,
            )[index];
        return  WidgetWithImage(
            title: item.name,
            imagePath: item.imageUrl,
            action:
                (context, routeName, title, enabled) =>
                    categoriesService.onPressedImage(
                      context,
                      item.routeName,
                      item.name,
                      item.enabled,
                    ),
            routeName: item.routeName,
            enabled: item.enabled,
          );
      },
      itemCount:
          AppConstants.allCategoriesItems(AppLocalizations.of(context)!).length,
    );
  }
}



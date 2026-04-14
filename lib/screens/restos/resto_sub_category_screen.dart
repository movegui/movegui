import 'package:flutter/material.dart';
import 'package:movegui/screens/inner_screen/product_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';

class RestoSubCategoryScreen extends StatelessWidget {
  const RestoSubCategoryScreen({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  void _onPressedImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
  ) {
    if (enabled)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductScreen(navigatorKey: navigatorKey),
        ),
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
            ),
            WidgetWithImage(
              title: 'Burger',
              routeName: '',
              imagePath: AssetsManager.fast_food,
              action: _onPressedImage,
              enabled: false,
            ),
            WidgetWithImage(
              title: 'Sandwisch',
              routeName: '',
              imagePath: AssetsManager.category3Image,
              action: _onPressedImage,
              enabled: false,
            ),
            WidgetWithImage(
              title: 'Vegan',
              routeName: '',
              imagePath: AssetsManager.category4Image,
              action: _onPressedImage,
              enabled: false,
            ),
            WidgetWithImage(
              title: 'BBQ',
              routeName: '',
              imagePath: AssetsManager.category5Image,
              action: _onPressedImage,
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}

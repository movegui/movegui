import 'package:flutter/material.dart';
import 'package:movegui/screens/inner_screen/product_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/category/category_item_widget.dart';

class CategoryWidget extends StatelessWidget{
  const CategoryWidget({super.key, required this.navigatorKey});
    final GlobalKey<NavigatorState> navigatorKey;

  void _onPressedImage(BuildContext context, String routeName, String title) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen(navigatorKey: navigatorKey,)));
  }

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(6),
      child: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              CategoryItem(
                  title: 'Pizza',
                  routeName: '',
                  imagePath: AssetsManager.category1Image,
                  action: _onPressedImage,
                ),
                CategoryItem(
                  title: 'Fast Food',
                  routeName: '',
                  imagePath: AssetsManager.category2Image,
                  action: _onPressedImage,
                ),
                CategoryItem(
                  title: 'Sandwisch',
                  routeName: '',
                  imagePath: AssetsManager.category3Image,
                  action: _onPressedImage,
                ),
                CategoryItem(
                  title: 'Vegan',
                  routeName: '',
                  imagePath: AssetsManager.category4Image,
                  action: _onPressedImage,
                ),
                CategoryItem(
                  title: 'BBQ',
                  routeName: '',
                  imagePath: AssetsManager.category5Image,
                  action: _onPressedImage,
                ),
        ],

      ),)
    );
  }
}

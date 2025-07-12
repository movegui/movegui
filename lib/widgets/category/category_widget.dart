import 'package:flutter/material.dart';
import 'package:movegui/screens/product_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/category/category_item_widget.dart';

class CategoryWidget extends StatelessWidget{
  const CategoryWidget({super.key});

  void _onPressedImage(BuildContext context, int index, String title) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen()));
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
                  imagePath: AssetsManager.category1Image,
                  action: _onPressedImage,
                  index: 0,
                ),
                CategoryItem(
                  title: 'Fast Food',
                  imagePath: AssetsManager.category2Image,
                  action: _onPressedImage,
                  index: 1,
                ),
                CategoryItem(
                  title: 'Sandwisch',
                  imagePath: AssetsManager.category3Image,
                  action: _onPressedImage,
                  index: 2,
                ),
                CategoryItem(
                  title: 'Vegan',
                  imagePath: AssetsManager.category4Image,
                  action: _onPressedImage,
                  index: 3,
                ),
                CategoryItem(
                  title: 'BBQ',
                  imagePath: AssetsManager.category5Image,
                  action: _onPressedImage,
                  index: 4,
                ),
        ],

      ),)
    );
  }
}

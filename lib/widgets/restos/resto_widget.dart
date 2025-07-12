import 'package:flutter/material.dart';
import 'package:movegui/screens/resto_category_screnn.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/restos/resto_item_widget.dart';

class RestoWidget extends StatelessWidget{
  const RestoWidget({super.key});

  void _onPressedImage(BuildContext context, int index, String title) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RestoCategoryScreen()));
  }



  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(6),
      child: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              RestoItem(
                  title: 'Resto1',
                  imagePath: AssetsManager.resto1Image,
                  action: _onPressedImage,
                  index: 0,
                ),
                RestoItem(
                  title: 'Resto2',
                  imagePath: AssetsManager.resto2Image,
                  action: _onPressedImage,
                  index: 1,
                ),
                RestoItem(
                  title: 'Resto3',
                  imagePath: AssetsManager.resto3Image,
                  action: _onPressedImage,
                  index: 2,
                ),
                RestoItem(
                  title: 'Resto4',
                  imagePath: AssetsManager.resto4Image,
                  action: _onPressedImage,
                  index: 3,
                ),
                RestoItem(
                  title: 'Resto5',
                  imagePath: AssetsManager.resto5Image,
                  action: _onPressedImage,
                  index: 4,
                ),
        ],

      ),)
    );
  }
  
}

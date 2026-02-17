import 'package:flutter/material.dart';
import 'package:movegui/models/model.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/models/store_model.dart';
import 'package:movegui/screens/restos/resto_category_screnn.dart';
import 'package:movegui/widgets/store/store_item_widget.dart';

class StoreWidget extends StatelessWidget{
  final StoreModel model;
  final int catgory;
    final GlobalKey<NavigatorState> navigatorKey;
  const StoreWidget({super.key, required this.model, required this.catgory, required this.navigatorKey});





  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(6),
      child: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              StoreItem(model: this.model, category: catgory, navigatorKey: navigatorKey,),
                /*
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
                */
        ],

      ),)
    );
  }
  
}

import 'package:flutter/material.dart';
import 'package:movegui/services/assets_manager.dart';

class AppImage extends StatelessWidget {
  final num? height;

  const AppImage({super.key, this.height=0.3}); 
  
  @override
  Widget build(BuildContext context) {
    return Container(
          //    padding: EdgeInsets.all(6),
          //    margin: EdgeInsets.symmetric(horizontal: 2),
              width: MediaQuery.of(context).size.width, // 70% of screen width
              height: MediaQuery.of(context).size.height * height!,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(
                    AssetsManager.moveguiIcon,
                  ), // or NetworkImage
                  fit: BoxFit.fill, // covers entire container

                  /*
                   colorFilter: ColorFilter.mode(
                      Theme.of(context).scaffoldBackgroundColor, // Change this to your desired color and opacity
                      BlendMode.color, // Other modes: overlay, multiply, etc.
                    ),
                    */
                ),
              ),
              // child: Image.asset("assets/icons/movegui.jpg",),
            );
  }
  
}
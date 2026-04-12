import 'package:flutter/material.dart';
import 'package:movegui/services/assets_manager.dart';

class MoveguiMobileImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5, // 50% of screen width
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: DecorationImage(
          image: AssetImage(AssetsManager.moveguiIcon),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

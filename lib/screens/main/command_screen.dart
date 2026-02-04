

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/screens/categories/categories_screen.dart';

class Commandscreen extends StatelessWidget {
  const Commandscreen({super.key, required this.title});
  final String title;

  @override
  Widget build(Object context) {
   // return RestoScreen();
   return CategoriesScreen(categoryType: AppConstants.COMMANDCATEGORY,);
  }
  
}

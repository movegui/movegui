

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/screens/categories/categories_screen.dart';
import 'package:movegui/services/title_manager.dart';

class Commandscreen extends StatefulWidget {
    final Function(String) onTitleChange;
  const Commandscreen({super.key, required this.onTitleChange,});

  @override
  State<StatefulWidget> createState() => CommandScreenState();
  }
  


class CommandScreenState extends State<Commandscreen>  {

  @override
  void initState() {
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.commandTitle);
    });
  }

  @override
  Widget build(Object context) {
   // return RestoScreen();
   return CategoriesScreen(categoryType: AppConstants.COMMAND_CATEGORY,);
  }
}

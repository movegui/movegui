import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/screens/categories/categories_screen.dart';
import 'package:movegui/services/title_manager.dart';

class CourierScreen extends StatefulWidget {
  const CourierScreen({super.key, required this.onTitleChange});
  final Function(String) onTitleChange;

  @override
  State<StatefulWidget> createState() => CourierScreenState();
}

class CourierScreenState extends State<CourierScreen> {


  @override
  void initState() {
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.courseTitle);
    });
  }

  @override
  Widget build(Object context) {
    return CategoriesScreen(categoryType: AppConstants.COURSES_CATEGORY);
  }
}

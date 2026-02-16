
import 'package:flutter/material.dart';
import 'package:movegui/screens/categories/resto_screen.dart';
import 'package:movegui/services/title_manager.dart';

class DeveliveryScreen extends StatefulWidget{
  const DeveliveryScreen({super.key, required this.onTitleChange,});
      final Function(String) onTitleChange;


  
  @override
  State<StatefulWidget> createState() => DeveliveryScreenState();
}

class DeveliveryScreenState extends State<DeveliveryScreen> {

  @override
  void initState() {
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.livraisonTitle);
    });
  }
 
   @override
  Widget build(Object context) {
    return RestoScreen();
  }

}
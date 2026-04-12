import 'package:flutter/material.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    final shoppingProvider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
     // appBar: MoveguiAppBar(title: 'Notification', itemCount: shoppingProvider.itemCount,),
    );
  }
  
}
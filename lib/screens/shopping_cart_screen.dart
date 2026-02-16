import 'package:flutter/material.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    return Scaffold(
    //  appBar: MoveguiAppBar(title: 'Mes Produits', itemCount: shoppingProvider.itemCount,),
    );
  }
  
}
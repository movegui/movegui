import 'package:flutter/material.dart';
import 'package:movegui/widgets/app/appbar.dart';

class ShoppingCartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoveguiAppBar(title: 'Mes Produits'),
    );
  }
  
}
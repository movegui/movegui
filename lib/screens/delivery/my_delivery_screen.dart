import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';

class MyDeliveryScreen extends StatefulWidget{

  final Function(String) onTitleChange;
  const MyDeliveryScreen({
    super.key,
    required this.onTitleChange,
  });


  @override
  State<StatefulWidget> createState() => MyDeliveryScreenState();
}

class MyDeliveryScreenState extends State<MyDeliveryScreen>{

  @override
  void initState() {
           WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(AppLocalizations.of(context)!.my_orders_title);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Text('My Delivery Screen In Implementation');
  }
  
}
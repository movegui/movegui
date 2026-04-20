
import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';

class MyOrderScreen extends StatefulWidget{

  final Function(String) onTitleChange;
  const MyOrderScreen({
    super.key,
    required this.onTitleChange,
  });


  @override
  State<StatefulWidget> createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<MyOrderScreen>{

@override
  void initState() {
       WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(AppLocalizations.of(context)!.my_orders_title);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text('My Order Screen In Implementation');
  }
  
}
import 'package:flutter/material.dart';



class DeliveryScreen extends StatefulWidget{

  const DeliveryScreen({
    super.key,
  });


  @override
  State<StatefulWidget> createState() => MyDeliveryScreenState();
}

class MyDeliveryScreenState extends State<DeliveryScreen>{

  @override
  void initState() {
    super.initState();
  }

/*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppbarTitleProvider>().setTitle(
        AppLocalizations.of(context)!.my_deliveries_title,
      );
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Text('My Delivery Screen In Implementation');
  }
  
}
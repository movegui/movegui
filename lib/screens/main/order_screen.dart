import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key,});

  @override
  State<StatefulWidget> createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<OrderScreen> {
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
        AppLocalizations.of(context)!.my_orders_title,
      );
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Text('My Order Screen In Implementation');
  }
}

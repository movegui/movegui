import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final Function(String) onTitleChange;
  const OrderScreen({super.key, required this.onTitleChange});

  @override
  State<StatefulWidget> createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppbarTitleProvider>().setTitle(
        AppLocalizations.of(context)!.my_orders_title,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('My Order Screen In Implementation');
  }
}

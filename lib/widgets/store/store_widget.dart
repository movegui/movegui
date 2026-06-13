import 'package:flutter/material.dart';
import 'package:movegui/models/store_model.dart';
import 'package:movegui/widgets/store/store_item_widget.dart';

class StoreWidget extends StatelessWidget {
  final StoreModel model;
  final int catgory;
  const StoreWidget({
    super.key,
    required this.model,
    required this.catgory,
    //required this.navigatorKey
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [StoreItemWidget(model: this.model, category: catgory)],
        ),
      ),
    );
  }
}

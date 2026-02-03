
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/patisserie_model.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/screens/main/command_screen.dart';
import 'package:movegui/screens/main/develivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/reservation_screen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:movegui/services/patisseries_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/restaurants_service.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/app/root_bottom_navigation_bar.dart';
import 'package:movegui/widgets/store/store_widget.dart';
import 'package:provider/provider.dart';

class PatisserieScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => PatisserieScreenState();

}

class PatisserieScreenState extends State<PatisserieScreen>{
 
 late TextEditingController searchTextController;
  List<PatisserieModel> patisseries = [];
  late PatisseriesService patisserieService;
  final patisserieConstants = PatisserieConstants();
    


  @override
  void initState() {
    searchTextController = TextEditingController();
     patisserieService = getIt<PatisseriesService>();
      initList();
    super.initState();

  }

    Future<void> initList() async {
    final allPatisseries = await patisserieService.allModels();
    setState(() {
      patisseries = allPatisseries;
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
      final shoppingProvider = Provider.of<ShoppingProvider>(context);
  return Material(
    color: Colors.transparent, // or Colors.white
    child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MoveguiAppBar(title: patisserieConstants.getTitleName(), itemCount: shoppingProvider.itemCount),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
        
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                    },
                    child: const Icon(Icons.clear, color: Colors.red),
                  ),
                ),
              ),
        
              const SizedBox(height: 15),
        
              Expanded(
                child: DynamicHeightGridView(
                  itemCount: patisseries.length,
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  builder: (context, index) {
                    return StoreWidget(model: patisseries[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        /*
        bottomNavigationBar:RootBottomNavigationBar(
        currentIndex: 1,
        onDestinationSelected: (index) {
          Navigator.pop(context, index);
        },
      ),
      */
      ),
    ),
  );
}

}
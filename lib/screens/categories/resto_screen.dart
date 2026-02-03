

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/restaurants_service.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/store/store_widget.dart';
import 'package:provider/provider.dart';


class RestoScreen extends StatefulWidget {
  const RestoScreen({super.key});

  @override
  State<RestoScreen> createState() => _RestoScreenState();
}

class _RestoScreenState extends State<RestoScreen> {
  late TextEditingController searchTextController;
  List<RestaurantModel> restaurants = [];
  late RestaurantsService restaurantsService;
  final restaurantConstants = RestaurantConstants();
    


  @override
  void initState() {
    searchTextController = TextEditingController();
     restaurantsService = getIt<RestaurantsService>();
      initList();
    super.initState();

  }

    Future<void> initList() async {
    final allRestaurants = await restaurantsService.allModels();
    setState(() {
      restaurants = allRestaurants;
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
        appBar: MoveguiAppBar(title: restaurantConstants.getTitleName(), itemCount: shoppingProvider.itemCount),
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
                  itemCount: restaurants.length,
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  builder: (context, index) {
                    return StoreWidget(model: restaurants[index]);
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


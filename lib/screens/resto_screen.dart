
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/restaurants_service.dart';
import 'package:movegui/widgets/restos/resto_widget.dart';


class RestoScreen extends StatefulWidget {
  const RestoScreen({super.key});

  @override
  State<RestoScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<RestoScreen> {
  late TextEditingController searchTextController;
  List<RestaurantModel> restaurants = [];
  late RestaurantsService restaurantsService;

    
  late List<Widget> screens;
   int currentScreen = 0;
  late PageController controller;

  @override
  void initState() {
    searchTextController = TextEditingController();
     restaurantsService = getIt<RestaurantsService>();
      initList();
    super.initState();
           screens = [
      HomeScreen(title: 'Home',),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande',),
      DeveliveryScreen(title: 'Livraison',)

    ];
    controller = PageController(initialPage: currentScreen);
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
  return Material(
    color: Colors.transparent, // or Colors.white
    child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
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
                  return RestoWidget(model: restaurants[index]);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}


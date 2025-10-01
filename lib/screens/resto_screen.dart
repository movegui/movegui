import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/widgets/category/category_widget.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:movegui/widgets/restos/resto_widget.dart';
import 'package:movegui/widgets/title_text.dart';

class RestoScreen extends StatefulWidget {
  const RestoScreen({super.key});

  @override
  State<RestoScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<RestoScreen> {
  late TextEditingController searchTextController;

    
  late List<Widget> screens;
   int currentScreen = 0;
  late PageController controller;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
           screens = [
      HomeScreen(title: 'Home',),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande',),
      DeveliveryScreen(title: 'Livraison',)

    ];
    controller = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // setState(() {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                      // });
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  log("value of the text is $value");
                },
                onSubmitted: (value) {
                  // log("value of the text is $value");
                  // log("value of the controller text: ${searchTextController.text}");
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: DynamicHeightGridView(
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context, index) {
                      return const RestoWidget();
                    },
                    itemCount: 3,
                    crossAxisCount: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

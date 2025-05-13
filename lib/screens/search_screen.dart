import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/screens/auth/login.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/widgets/menu.dart';
import 'package:movegui/widgets/products/product_widget.dart';

import '../services/assets_manager.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
             appBar: AppBar(
        title: Text('Search products'),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF), // Set the title color
          fontSize: 20,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xFFFFFFFF),
              tooltip: 'Navigation menu',
              onPressed: () {
                //  _showMenu(context);
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Color(0xFF871A1C), // Customize color
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen()));
                       
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(title: 'Notification',)));
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
        drawer: MoveGuiMenu(),
        /*
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AssetsManager.shoppingCart,
            ),
          ),
          title: const TitlesTextWidget(label: "Search products"),
        ),
        */
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
                      return const ProductWidget();
                    },
                    itemCount: 200,
                    crossAxisCount: 2),
              ),
            ],
          ),
        ),
         bottomNavigationBar: 
      NavigationBarTheme(data: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        );
      }
      return const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.normal,
      );
    }),
  ),
       child: 
      NavigationBar(
        indicatorColor: Colors.transparent,
        selectedIndex: currentScreen,
         backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: AppColors.secondary,),
            icon: Icon(Icons.home, color: AppColors.white,),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.reservationIcon3), color: AppColors.secondary,),
            icon: ImageIcon(AssetImage(AssetsManager.reservationIcon3), color: AppColors.white, size: 24, ),
            label: "Reservation",
           
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), color: AppColors.secondary, size: 24,),
            icon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), color: AppColors.white,),
            label: "Commande",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), color: AppColors.secondary,),
            icon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), color: AppColors.white,),
            label: "Livraison",
          ),
        ],
      ),
    )
      ),
    );
  }
}

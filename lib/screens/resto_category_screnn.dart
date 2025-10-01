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
import 'package:movegui/widgets/title_text.dart';

class RestoCategoryScreen extends StatefulWidget {
  const RestoCategoryScreen({super.key});

  @override
  State<RestoCategoryScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<RestoCategoryScreen> {
  late TextEditingController searchTextController;

    

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
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
        title: Text('Search Category'),
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
                      return const CategoryWidget();
                    },
                    itemCount: 3,
                    crossAxisCount: 1),
              ),
            ],
          ),
        ),
              bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 130,
                child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "Addresse:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text(
                      'Kobaya commune de ratoma Conakry',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140,
                child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitlesTextWidget(
                      label: "E-Mail:",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('movegui@gmail.com', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                           TitlesTextWidget(
                      label: "Telephone",
                      color: Theme.of(context).secondaryHeaderColor,
                      decoration: TextDecoration.underline,
                    ),
                    Text('623-259-584', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        /*
         bottomNavigationBar: 
      NavigationBarTheme(
        data: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: AppColors.selectionColor,
          fontWeight: FontWeight.bold,
        );
      }
      return const TextStyle(
        color: AppColors.textColor,
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
            selectedIcon: Icon(Icons.home, color: AppColors.selectionColor,),
            icon: Icon(Icons.home, color: AppColors.textColor,),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.reservationIcon3), color: AppColors.selectionColor,),
            icon: ImageIcon(AssetImage(AssetsManager.reservationIcon3), color: AppColors.textColor, size: 24, ),
            label: "Reservation",
           
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), color: AppColors.selectionColor, size: 24,),
            icon: ImageIcon(AssetImage(AssetsManager.commandeIcon3), color: AppColors.textColor,),
            label: "Commande",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), color: AppColors.selectionColor,),
            icon: ImageIcon(AssetImage(AssetsManager.livraisonIcon3), color: AppColors.textColor,),
            label: "Livraison",
          ),
        ],
      ),
    )
    */
      ),
    );
  }
}

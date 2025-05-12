import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/screens/auth/login.dart';
import 'package:movegui/screens/command_screen.dart';
import 'package:movegui/screens/develivery_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/services/assets_manager.dart';
import 'package:movegui/widgets/menu.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({super.key, required this.currentScreen, required this.title});
  final int currentScreen;
  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<RootScreen> createState() => _RootScreenState(currentScreen: currentScreen, title: title);
}

class _RootScreenState extends State<RootScreen> {
      _RootScreenState({required this.currentScreen, required this.title});

  late List<Widget> screens;
   int currentScreen;
   String title;
  late PageController controller;
  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(title: title,),
      ReservationScreen(title: title),
      Commandscreen(title: title,),
      DeveliveryScreen(title: title,)

    ];
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(title),
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
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
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
    );
  }
}


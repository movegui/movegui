import 'package:flutter/material.dart';
import 'package:movegui/observers/home_nav_observer.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/screens/main/command_screen.dart';
import 'package:movegui/screens/main/develivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/courier_screen.dart';
import 'package:movegui/screens/main/movegui_screen.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/app/app_footer.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late int currentScreen;
  String title = TitleManager.homeTitle;
  static const double iconSize = 18.0;
  late HomeNavObserver homeObserver;
  final ValueNotifier<bool> homeCanPop = ValueNotifier(false);
  final GlobalKey<NavigatorState> barNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> commandNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> deliveryNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> courrierNavigatorKey =
      GlobalKey<NavigatorState>();
  final RouteObserver<ModalRoute<void>> homeRouteObserver =
      RouteObserver<ModalRoute<void>>();

  @override
  void initState() {
    super.initState();
    currentScreen = 0;
    homeObserver = HomeNavObserver(homeCanPop);
  }



  void updateTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    return Scaffold(
      appBar: MoveguiAppBar(
        title: title,
        itemCount: shoppingProvider.itemCount,
        navigatorKey: homeNavigatorKey,
        homeCanPop: homeCanPop,
        onTitleChange: (value) {
          updateTitle(value);
        },
      ),
      drawer: MoveGuiMenu(),
      body: IndexedStack(
        index: currentScreen,
        children: [
          _buildHomeNavigator(),
          _buildCommandNavigator(),
          _buildDeliveryNavigator(),
          _buildCoursesNavigator(),
        ],
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: currentScreen,
        iconSize: iconSize,
        onTap: (index) {
          setState(() {
            currentScreen = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeNavigator() {
    return Navigator(
      key: homeNavigatorKey,
      initialRoute: '/',
      observers: [homeObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = HomeScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: homeNavigatorKey,
              routeObserver: homeRouteObserver,
            );
            break;
          case '/home/movegui':
            page = MoveguiScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
            break;

          case '/command':
            page = Commandscreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
            break;
          case '/delivery':
            page = DeveliveryScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
            break;
          case '/courses':
            page = CourierScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
            break;

          default:
            page = HomeScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: homeNavigatorKey,
              routeObserver: homeRouteObserver,
            );
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildCommandNavigator() {
    return Navigator(
      key: commandNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (_) => Commandscreen(
                onTitleChange: (value) {
                  updateTitle(value);
                },
              ),
        );
      },
    );
  }

  Widget _buildDeliveryNavigator() {
    return Navigator(
      key: deliveryNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => DeveliveryScreen( onTitleChange: (value) {
                  updateTitle(value);
                },));
      },
    );
  }

  Widget _buildCoursesNavigator() {
    return Navigator(
      key: courrierNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => CourierScreen( onTitleChange: (value) {
                  updateTitle(value);
                },));
      },
    );
  }

  /*
  showUserMenu(BuildContext context) async {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Custom Dialog", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  */
}

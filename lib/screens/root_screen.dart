import 'package:another_flushbar/flushbar.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/observers/home_nav_observer.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/auth/register_screen.dart';
import 'package:movegui/screens/categories/patisserie_screen.dart';
import 'package:movegui/screens/categories/pressing_screen.dart';
import 'package:movegui/screens/categories/resto_screen.dart';
import 'package:movegui/screens/categories/super_markt_screen.dart';
import 'package:movegui/screens/main/command_screen.dart';
import 'package:movegui/screens/main/develivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/courier_screen.dart';
import 'package:movegui/screens/main/movegui_screen.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/app/app_footer.dart';
import 'package:movegui/widgets/app/app_footer_web.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/util/tab_button.dart';
import 'package:movegui/widgets/web/menu_bar_web.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedTabIndex = 0; // make this stateful
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
  final GlobalKey<NavigatorState> webNavigatorKey = GlobalKey<NavigatorState>();

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
      appBar:
          Responsive.isDesktop(context)
              ? MenuBarWeb()
              : MoveguiAppBar(
                title: title,
                itemCount: shoppingProvider.itemCount,
                navigatorKey: homeNavigatorKey,
                homeCanPop: homeCanPop,
                onTitleChange: (value) {
                  updateTitle(value);
                },
              ),
      drawer: MoveGuiMenu(navigatorKey: homeNavigatorKey),
      body:
          Responsive.isDesktop(context)
              ? SafeArea(
                child: Column(
                  children: [
                    _buildWebTabs(context),
                    const SizedBox(height: 20),
                    _builWebdCategoriesWidget(context),
                    const SizedBox(height: 30),
                  ],
                ),
              )
              : IndexedStack(
                index: currentScreen,
                children: [
                  _buildHomeNavigator(),
                  _buildCommandNavigator(),
                  _buildDeliveryNavigator(),
                  _buildCoursesNavigator(),
                ],
              ),

      bottomNavigationBar:
          Responsive.isDesktop(context)
              ? AppFooterWeb()
              : AppFooter(
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
              // routeObserver: homeRouteObserver,
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
              navigatorKey: commandNavigatorKey,
            );
            break;
          case '/delivery':
            page = DeveliveryScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: deliveryNavigatorKey,
            );
            break;
          case '/courses':
            page = CourierScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: courrierNavigatorKey,
            );
            break;

          case '/login':
            page = LoginScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: homeNavigatorKey,
            );
            break;

          case 'register':
            page = RegisterScreenMovgui(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: homeNavigatorKey,
            );

          default:
            page = HomeScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
              navigatorKey: homeNavigatorKey,
              //  routeObserver: homeRouteObserver,
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
                navigatorKey: commandNavigatorKey,
              ),
        );
      },
    );
  }

  Widget _buildDeliveryNavigator() {
    return Navigator(
      key: deliveryNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (_) => DeveliveryScreen(
                onTitleChange: (value) {
                  updateTitle(value);
                },
                navigatorKey: deliveryNavigatorKey,
              ),
        );
      },
    );
  }

  Widget _buildCoursesNavigator() {
    return Navigator(
      key: courrierNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (_) => CourierScreen(
                onTitleChange: (value) {
                  updateTitle(value);
                },
                navigatorKey: courrierNavigatorKey,
              ),
        );
      },
    );
  }
/*
  Widget _buildWebNavigator() {
    return Navigator(
      key: webNavigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case '/':
            page = Column(
              children: [
                _buildTabs(),
                const SizedBox(height: 20),
                _buildCategories(),
              ],
            );
            break;

          case '/login':
            page = LoginScreen(
              onTitleChange: (_) {},
              navigatorKey: webNavigatorKey,
            );
            break;

          case '/register':
            page = RegisterScreenMovgui(
              onTitleChange: (_) {},
              navigatorKey: webNavigatorKey,
            );
            break;

          case '/restaurant':
            page = RestoScreen(navigatorKey: webNavigatorKey);
            break;

          case '/pressing':
            page = PressingScreen(navigatorKey: webNavigatorKey);
            break;

          case '/pastry':
            page = PatisserieScreen(navigatorKey: webNavigatorKey);
            break;

          case '/super_markt':
            page = SuperMarktScreen(navigatorKey: webNavigatorKey);
            break;

          default:
            page = Container();
        }

        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }
  */

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

  Widget _buildWebTabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(AppConstants.menuTabs(AppLocalizations.of(context)!).length, (index) {
        final tab = AppConstants.menuTabs(AppLocalizations.of(context)!)[index];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabButton(
              selected: selectedTabIndex == index,
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                  _onPressedImage(context, tab.routeName, title, tab.enabled);
                  /*
                  if(tab.enabled)
                    Navigator.pushNamed(context, tab.routeName);
                    else
                    */
                });
                //   webNavigatorKey.currentState!.pushNamed(tab.routeName);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(tab.icon, size: 18),
                  const SizedBox(width: 6),
                  Text(tab.title),
                ],
              ),
            ),
            if (index != AppConstants.menuTabs(AppLocalizations.of(context)!).length - 1)
              const SizedBox(width: 20),
          ],
        );
      }),
    );
  }

  void _onPressedImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
  ) {
    if (enabled)
      Navigator.pushNamed(context, routeName);
    else
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
  }

  Widget _builWebdCategoriesWidget(BuildContext context) {
    return Expanded(
      child: DynamicHeightGridView(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        builder: (context, index) {
          return WidgetWithImage(
            title: AppConstants.categoriesItems(AppLocalizations.of(context)!)[index].name,
            imagePath: AppConstants.categoriesItems(AppLocalizations.of(context)!)[index].imageUrl,
            action: _onPressedImage,
            routeName: AppConstants.categoriesItems(AppLocalizations.of(context)!)[index].routeName,
            enabled: AppConstants.categoriesItems(AppLocalizations.of(context)!)[index].enabled,
          );
        },
        itemCount: AppConstants.categoriesItems(AppLocalizations.of(context)!).length,
        crossAxisCount: 5,
      ),
    );
  }
}

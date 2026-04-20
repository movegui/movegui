import 'package:another_flushbar/flushbar.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/observers/home_nav_observer.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/auth/movegui_forgot_password_screen.dart';
import 'package:movegui/screens/auth/movegui_register_screen.dart';
import 'package:movegui/screens/delivery/my_delivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/modules/pressing_screen.dart';
import 'package:movegui/screens/order/my_order_screen.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/app/app_footer.dart';
import 'package:movegui/widgets/app/app_footer_web.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/util/tab_button.dart';
import 'package:movegui/widgets/web/menu_bar_web.dart';
import 'package:provider/provider.dart';

enum ActiveNavigator { home, command, delivery, courier }

class RootScreen extends StatefulWidget {
  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late String title;
  int selectedTabIndex = 0; // make this stateful
  late int currentScreen;
  static const double iconSize = 18.0;
  late HomeNavObserver homeObserver;
  late HomeNavObserver commandObserver;
  late HomeNavObserver deliveryObserver;
  late HomeNavObserver profileObserver;
  final ValueNotifier<bool> homeCanPop = ValueNotifier(false);
  final ValueNotifier<bool> commandCanPop = ValueNotifier(false);
  final ValueNotifier<bool> deliveryanPop = ValueNotifier(false);
  final ValueNotifier<bool> profileCanPop = ValueNotifier(false);
  final GlobalKey<NavigatorState> barNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> commandNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> deliveryNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>();
  final RouteObserver<ModalRoute<void>> homeRouteObserver =
      RouteObserver<ModalRoute<void>>();
  final GlobalKey<NavigatorState> webNavigatorKey = GlobalKey<NavigatorState>();

  final ValueNotifier<ActiveNavigator> activeNavigator = ValueNotifier(
    ActiveNavigator.home,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    title = AppLocalizations.of(context)!.home_title;
  }

  @override
  void initState() {
    super.initState();
    currentScreen = 0;
    /*
    if(!mounted)
    return;
    title = AppLocalizations.of(context)!.home_title;
    */

    //     String title = AppLocalizations.of(context)!.home_title;
    homeObserver = HomeNavObserver(
      homeCanPop,

      onRouteChanged: (route) {
        switch (route) {
          case '/home':
            updateTitle(AppLocalizations.of(context)!.home_title);
            activeNavigator.value = ActiveNavigator.home;
            break;
          case '/command':
            updateTitle(AppLocalizations.of(context)!.my_orders_title);
            break;
          case '/delivery':
            updateTitle(AppLocalizations.of(context)!.my_deliveries_title);
            break;
          case '/profile':
            updateTitle(AppLocalizations.of(context)!.profile_title);
            activeNavigator.value = ActiveNavigator.courier;
            break;
          default:
            updateTitle(AppLocalizations.of(context)!.home_title);
            activeNavigator.value = ActiveNavigator.home;
        }
      },
    );
    commandObserver = HomeNavObserver(commandCanPop);
    deliveryObserver = HomeNavObserver(deliveryanPop);
    profileObserver = HomeNavObserver(profileCanPop);
  }

  void updateTitle(String newTitle) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      setState(() {
        print('Hallo $newTitle');
        switch (currentScreen) {
          case 0:
            title = AppLocalizations.of(context)!.home_title;
            break;
          case 1:
            title = AppLocalizations.of(context)!.my_orders_title;
            break;
          case 2:
            title = AppLocalizations.of(context)!.my_deliveries_title;
            break;
          case 3:
            title = newTitle;
            /*
            if (title == AppLocalizations.of(context)!.profile_title &&
                newTitle == AppLocalizations.of(context)!.login_title)
              title = AppLocalizations.of(context)!.login_title;
            else if (title == AppLocalizations.of(context)!.profile_title &&
                newTitle == AppLocalizations.of(context)!.register_title)
              title = AppLocalizations.of(context)!.register_title;
            else if (title == AppLocalizations.of(context)!.profile_title &&
                newTitle == AppLocalizations.of(context)!.forget_password_title)
              title = AppLocalizations.of(context)!.forget_password_title;
            else if (title == AppLocalizations.of(context)!.profile_title &&
                newTitle == AppLocalizations.of(context)!.pressing_title)
              title = AppLocalizations.of(context)!.pressing_title;
            else
              title = AppLocalizations.of(context)!.profile_title;
              */

            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //  title = AppLocalizations.of(context)!.home_title;
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    return Scaffold(
      appBar:
          Responsive.isDesktop(context)
              ? MenuBarWeb()
              : MoveguiAppBar(
                title: title,
                itemCount: shoppingProvider.itemCount,
                homenavigatorKey: homeNavigatorKey,
                homeCanPop: homeCanPop,
                onTitleChange: (value) {
                  updateTitle(value);
                },
                activeNavigator: activeNavigator,
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
                  _buildMyOrdersNavigator(),
                  _buildMyDeliveriesNavigator(),
                  _buildProfileNavigator(),
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
                    switch (index) {
                      case 0:
                        updateTitle(AppLocalizations.of(context)!.home_title);
                        activeNavigator.value = ActiveNavigator.home;
                        break;
                      case 1:
                        updateTitle(
                          AppLocalizations.of(context)!.my_orders_title,
                        );
                        break;
                      case 2:
                        updateTitle(
                          AppLocalizations.of(context)!.my_deliveries_title,
                        );
                        break;
                      case 3:
                        updateTitle(
                          AppLocalizations.of(context)!.profile_title,
                        );
                        activeNavigator.value = ActiveNavigator.courier;
                        break;
                    }
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
            );
            break;

          case '/pressing':
            page = PressingScreen(
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
            );
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildMyOrdersNavigator() {
    return Navigator(
      key: commandNavigatorKey,
      initialRoute: '/myOrders',
      observers: [commandObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/myOrders':
            page = MyOrderScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
            break;

          default:
            page = MyOrderScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildMyDeliveriesNavigator() {
    return Navigator(
      key: deliveryNavigatorKey,
      initialRoute: '/myDeliveries',
      observers: [deliveryObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name ?? '/myDeliveries') {
          case '/myDeliveries':
            page = MyDeliveryScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
            break;

          default:
            page = MyDeliveryScreen(
              onTitleChange: (value) {
                updateTitle(value);
              },
            );
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildProfileNavigator() {
    return Navigator(
      // key: profileNavigatorKey,
      initialRoute: '/profile',
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case RouteContants.PROFILE_ROUTE:
            page =
                FirebaseAuth.instance.currentUser == null
                    ? LoginScreen(
                      onTitleChange: (newTitle) {
                        print('im here');
                        updateTitle(newTitle);
                      },
                    )
                    : const ProfileScreen();
            break;
          case RouteContants.REGISTER_ROUTE:
            page =
                FirebaseAuth.instance.currentUser == null
                    ? MoveguiRegisterScreen(
                      onTitleChange: (newTitle) {
                        updateTitle(newTitle);
                      },
                    )
                    : const ProfileScreen();
            break;
          case RouteContants.FORGET_PASSWORD_ROUTE:
            final args = settings.arguments as Map<String, dynamic>;
            page =
                FirebaseAuth.instance.currentUser == null
                    ? MoveguiForgotPasswordScreen(
                      onTitleChange: (newTitle) {
                        updateTitle(newTitle);
                      },
                    )
                    /*
                    ForgotPasswordScreen(
                      email: args['email'],
                      // subtitleBuilder: (context) => Text('test'),
                      headerBuilder: (context, constraints, shrinkOffset) => AppImage(),
                    )
                    */
                    : const ProfileScreen();
            break;

          default:
            page =
                FirebaseAuth.instance.currentUser == null
                    ? LoginScreen(
                      onTitleChange: (newTitle) {
                        updateTitle(newTitle);
                      },
                    )
                    : const ProfileScreen();
        }

        return MaterialPageRoute(settings: settings, builder: (_) => page);
      },
    );
  }

  /*
Widget _buildProfileNavigator() {
  return Navigator(
    key: profileNavigatorKey,
    observers: [profileObserver],
    onGenerateRoute: (settings) {
      return MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      );
    },
  );
}
*/

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
      children: List.generate(
        AppConstants.menuTabs(AppLocalizations.of(context)!).length,
        (index) {
          final tab =
              AppConstants.menuTabs(AppLocalizations.of(context)!)[index];

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabButton(
                selected: selectedTabIndex == index,
                onTap: () {
                  setState(() {
                    selectedTabIndex = index;
                    _onPressedImage(
                      context,
                      tab.routeName,
                      title,
                      tab.enabled,
                      // null,
                    );
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
              if (index !=
                  AppConstants.menuTabs(AppLocalizations.of(context)!).length -
                      1)
                const SizedBox(width: 20),
            ],
          );
        },
      ),
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
            title:
                AppConstants.allCategoriesItems(
                  AppLocalizations.of(context)!,
                )[index].name,
            imagePath:
                AppConstants.allCategoriesItems(
                  AppLocalizations.of(context)!,
                )[index].imageUrl,
            action: _onPressedImage,
            routeName:
                AppConstants.allCategoriesItems(
                  AppLocalizations.of(context)!,
                )[index].routeName,
            enabled:
                AppConstants.allCategoriesItems(
                  AppLocalizations.of(context)!,
                )[index].enabled,
            //navigatorkey: null,
          );
        },
        itemCount:
            AppConstants.allCategoriesItems(
              AppLocalizations.of(context)!,
            ).length,
        crossAxisCount: 5,
      ),
    );
  }
}

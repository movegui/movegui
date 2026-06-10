import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/screens/main/delivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/movegui_profile_screen.dart';
import 'package:movegui/screens/main/order_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_footer.dart';
import 'package:movegui/widgets/app/app_footer_web.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/web/menu_bar_web.dart';

enum ActiveNavigator { home, order, delivery, profile }

class RootScreenOld extends ConsumerStatefulWidget {
  RootScreenOld({super.key});

  @override
  ConsumerState<RootScreenOld> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreenOld> {
  late String title;
  int selectedTabIndex = 0; // make this stateful
  late int currentScreen;
  static const double iconSize = 18.0;

  XFile? _pickedImage;
  File? pickedImage;
  Uint8List? webImage;

  late String gender;
  late DateTime birthdate;

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
    homeObserver = HomeNavObserver(homeCanPop);
    commandObserver = HomeNavObserver(commandCanPop);
    deliveryObserver = HomeNavObserver(deliveryanPop);
    profileObserver = HomeNavObserver(profileCanPop);
    */
  }

  Future<void> localImagePicker(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        setState(() {
          webImage = bytes;
        });
      },
      galleryFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        setState(() {
          webImage = bytes;
        });
      },
      removeFCT: () {
        setState(() {
          webImage = null;
        });
      },
    );
  }

  void updateTitle(String routeName, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      switch (routeName) {
        default:
          '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Responsive.isDesktop(context)
              ? MenuBarWeb(title: title)
              : MoveguiAppBar(
                title: title,
                itemCount: ref.watch(shoppingProvider).itemCount,
                /*
                homeCanPop: homeCanPop,
                activeNavigator: activeNavigator,
                homeNavigatorKey: homeNavigatorKey,
                orderNavigatorKey: commandNavigatorKey,
                deliveryNavigatorKey: deliveryNavigatorKey,
                profileNavigatorKey: profileNavigatorKey,
                orderCanPop: commandCanPop,
                deliveryCanPop: deliveryanPop,
                profileCanPop: profileCanPop,
                */
              ),
      drawer: MoveGuiMenu(),

      body:
          Responsive.isDesktop(context)
              ? HomeScreen(
                selectedTabIndex: selectedTabIndex,
                onTabChange: (int index) {
                  selectedTabIndex = index;
                },
              )
              : IndexedStack(
                index: currentScreen,
                children: [
                  HomeScreen(currentScreen: currentScreen),
                  OrderScreen(),
                  DeliveryScreen(),
                  MoveguiProfileScreen(),
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
                      /*
                      case 0:
                        context.read<AppbarTitleProvider>().setTitle(
                          AppLocalizations.of(context)!.home_title,
                        );
                        activeNavigator.value = ActiveNavigator.home;
                        break;
                      case 1:
                        context.read<AppbarTitleProvider>().setTitle(
                          AppLocalizations.of(context)!.my_orders_title,
                        );
                        activeNavigator.value = ActiveNavigator.order;
                        break;
                      case 2:
                        context.read<AppbarTitleProvider>().setTitle(
                          AppLocalizations.of(context)!.my_deliveries_title,
                        );
                        activeNavigator.value = ActiveNavigator.delivery;
                        break;
                      case 3:
                        context.read<AppbarTitleProvider>().setTitle(
                          AppLocalizations.of(context)!.profile_title,
                        );
                        activeNavigator.value = ActiveNavigator.profile;
                        break;
                        */
                      default:
                        '';
                    }
                  });
                },
              ),
    );
  }

  /*
  Widget _buildHomeNavigator(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      initialRoute: '/',
      observers: [homeObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/home':
            page = HomeScreen(currentScreen: currentScreen,);
            break;

          case '/':
            page = HomeScreen(currentScreen: currentScreen,);
            break;

          case '/pressing':
            page = PressingScreen();
            break;

          default:
            page = HomeScreen(currentScreen: currentScreen,);
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildMyOrdersNavigator(BuildContext context) {
    return Navigator(
      key: commandNavigatorKey,
      initialRoute: '/myOrders',
      observers: [commandObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/myOrders':
            page = OrderScreen();
            break;

          default:
            page = OrderScreen();
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildMyDeliveriesNavigator(BuildContext context) {
    return Navigator(
      key: deliveryNavigatorKey,
      initialRoute: '/myDeliveries',
      observers: [deliveryObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name ?? '/myDeliveries') {
          case '/myDeliveries':
            page = DeliveryScreen();
            break;

          case '/':
            page = HomeScreen();
            break;

          default:
            page = DeliveryScreen();
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  Widget _buildProfileNavigator(BuildContext context) {
    return Navigator(
      key: profileNavigatorKey,
      initialRoute: '/profile',
      observers: [
        HomeNavObserver(
          profileCanPop,
          onRouteChanged: (routeName) => updateTitle(routeName, context),
        ),
      ],
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case RouteConstants.PROFILE_ROUTE:
            final args = settings.arguments;
            if (args != null) {
              page = MoveguiProfileScreen(currentUser: args as UserModel);
            } else {
              page = MoveguiProfileScreen();
            }
            break;

          case '/':
            page = MoveguiProfileScreen();
            break;

          case RouteConstants.OTP_SCREEN_ROUTE:
            final args = settings.arguments;
            if (args is OptArgsModel) {
              page = OtpVerificationScreen(
                verificationId: args.verificationId,
                currentUser: args.currentUser,
                confirmationResult: args.confirmationResult,
              );
            } else {
              page = LoginScreen();
            }
            break;

          case RouteConstants.REGISTER_ROUTE:
            page = MoveguiRegisterScreen();
            break;
          case RouteConstants.LOGIN_ROUTE:
            page = LoginScreen();
            break;
          case RouteConstants.FORGET_PASSWORD_ROUTE:
            final args = settings.arguments as Map<String, dynamic>;
            page = MoveguiForgotPasswordScreen();
            break;

          default:
            page = MoveguiProfileScreen();
            ;
        }

        return MaterialPageRoute(settings: settings, builder: (_) => page);
      },
    );
  }

  */

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
}

import 'dart:io';
import 'dart:typed_data';

//import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/observers/home_nav_observer.dart';
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

class RootScreen extends ConsumerStatefulWidget {
  RootScreen({super.key});

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
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
    homeObserver = HomeNavObserver(homeCanPop);
    commandObserver = HomeNavObserver(commandCanPop);
    deliveryObserver = HomeNavObserver(deliveryanPop);
    profileObserver = HomeNavObserver(profileCanPop);
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
        /*
        case RouteConstants.HOME_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.home_title,
          );
          activeNavigator.value = ActiveNavigator.home;
          break;
        case RouteConstants.MY_ORDERS_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.my_orders_title,
          );
          activeNavigator.value = ActiveNavigator.order;
          break;
        case RouteConstants.MY_DELIVERIS_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.my_deliveries_title,
          );
          activeNavigator.value = ActiveNavigator.delivery;
          break;
        case RouteConstants.PROFILE_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.profile_title,
          );
          activeNavigator.value = ActiveNavigator.profile;
          break;
        case RouteConstants.REGISTER_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.register_title,
          );
          activeNavigator.value = ActiveNavigator.profile;
          break;
        case RouteConstants.LOGIN_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.login_title,
          );
          break;
        case RouteConstants.PRESSING_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.pressing_title,
          );
          break;
        case RouteConstants.FORGET_PASSWORD_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.forget_password_title,
          );
          break;
          */
          default:  '';
      }
      //     context.read<AppbarTitleProvider>().setTitle(newTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  title = AppLocalizations.of(context)!.home_title;
   // final shoppingProvider = Provider.<ShoppingProvider>(context);
    // ignore: deprecated_member_use
    return 
    /*
    WillPopScope(
      onWillPop: () async {
        GlobalKey<NavigatorState>? currentKey;
        switch (activeNavigator.value) {
          case ActiveNavigator.home:
            currentKey = homeNavigatorKey;
            break;
          case ActiveNavigator.order:
            currentKey = commandNavigatorKey;
            break;
          case ActiveNavigator.delivery:
            currentKey = deliveryNavigatorKey;
            break;
          case ActiveNavigator.profile:
            currentKey = profileNavigatorKey;
            break;
        }
        final canPop = currentKey.currentState?.canPop() ?? false;
        if (canPop) {
          currentKey.currentState?.maybePop();
          return false;
        }
        return true;
      },
      child:
    )
    */
       Scaffold(
        
      appBar:
          Responsive.isDesktop(context)
              ? MenuBarWeb(title: title,)
              : MoveguiAppBar(
                title: title,
                itemCount: ref.watch(shoppingProvider).itemCount,
                homeCanPop: homeCanPop,
                activeNavigator: activeNavigator,
                homeNavigatorKey: homeNavigatorKey,
                orderNavigatorKey: commandNavigatorKey,
                deliveryNavigatorKey: deliveryNavigatorKey,
                profileNavigatorKey: profileNavigatorKey,
                orderCanPop: commandCanPop,
                deliveryCanPop: deliveryanPop,
                profileCanPop: profileCanPop,
              ),
      drawer: MoveGuiMenu(navigatorKey: homeNavigatorKey),
      
      body:
          Responsive.isDesktop(context)
              ? HomeScreen(selectedTabIndex: selectedTabIndex, onTabChange: (int index) { selectedTabIndex = index; }, )
              /*
              SafeArea(
                child: Column(
                  children: [
                    _buildWebTabs(context),
                    const SizedBox(height: 20),
                    _builWebdCategoriesWidget(context),
                    const SizedBox(height: 30),
                  ],
                ),
              )
              */
              : IndexedStack(
                index: currentScreen,
                children: [
                  HomeScreen(currentScreen: currentScreen,),
                   OrderScreen(),
                   DeliveryScreen(),
                   MoveguiProfileScreen(),



                  /*
                  _buildHomeNavigator(context),
                  _buildMyOrdersNavigator(context),
                  _buildMyDeliveriesNavigator(context),
                  _buildProfileNavigator(context),
                  */
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
                        default: '';
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



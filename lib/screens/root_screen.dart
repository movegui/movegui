import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/opt_args_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/observers/home_nav_observer.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/screens/auth/login_screen.dart';
import 'package:movegui/screens/auth/movegui_forgot_password_screen.dart';
import 'package:movegui/screens/auth/movegui_register_screen.dart';
import 'package:movegui/screens/auth/otp_verification_scxreen.dart';
import 'package:movegui/screens/main/delivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/movegui_profile_screen.dart';
import 'package:movegui/screens/modules/pressing_screen.dart';
import 'package:movegui/screens/main/order_screen.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_footer.dart';
import 'package:movegui/widgets/app/app_footer_web.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/util/tab_button.dart';
import 'package:movegui/widgets/web/menu_bar_web.dart';
import 'package:provider/provider.dart';

enum ActiveNavigator { home, order, delivery, profile }

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

  XFile? _pickedImage;
  File? pickedImage;
  Uint8List? webImage;

  late String gender;
  late DateTime birthdate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //  title = AppLocalizations.of(context)!.home_title;
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
        case RouteContants.HOME_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.home_title,
          );
          activeNavigator.value = ActiveNavigator.home;
          break;
        case RouteContants.MY_ORDERS_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.my_orders_title,
          );
          activeNavigator.value = ActiveNavigator.order;
          break;
        case RouteContants.MY_DELIVERIS_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.my_deliveries_title,
          );
          activeNavigator.value = ActiveNavigator.delivery;
          break;
        case RouteContants.PROFILE_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.profile_title,
          );
          activeNavigator.value = ActiveNavigator.profile;
          break;
        case RouteContants.REGISTER_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.register_title,
          );
          activeNavigator.value = ActiveNavigator.profile;
          break;
        case RouteContants.LOGIN_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.login_title,
          );
          break;
        case RouteContants.PRESSING_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.pressing_title,
          );
          break;
        case RouteContants.FORGET_PASSWORD_ROUTE:
          context.read<AppbarTitleProvider>().setTitle(
            AppLocalizations.of(context)!.forget_password_title,
          );
          break;
      }
      //     context.read<AppbarTitleProvider>().setTitle(newTitle);
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
                title: context.watch<AppbarTitleProvider>().title,
                itemCount: shoppingProvider.itemCount,
                //    homenavigatorKey: homeNavigatorKey,
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
                  _buildHomeNavigator(context),
                  _buildMyOrdersNavigator(context),
                  _buildMyDeliveriesNavigator(context),
                  _buildProfileNavigator(context),
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
                    }
                  });
                },
              ),
    );
  }

  Widget _buildHomeNavigator(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      initialRoute: '/',
      observers: [homeObserver],
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/home':
            page = HomeScreen();
            break;

          case '/':
            page = HomeScreen();
            break;

          case '/pressing':
            page = PressingScreen();
            break;

          default:
            page = HomeScreen();
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
          case RouteContants.PROFILE_ROUTE:
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

          case RouteContants.OTP_SCREEN_ROUTE:
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

          case RouteContants.REGISTER_ROUTE:
            page = MoveguiRegisterScreen();
            break;
          case RouteContants.LOGIN_ROUTE:
            page = LoginScreen();
            break;
          case RouteContants.FORGET_PASSWORD_ROUTE:
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

import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/screens/root_screen.dart';

class MoveguiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoveguiAppBar({
    super.key,
    required this.title,
    required this.itemCount,
    required this.homeCanPop,
    required this.activeNavigator,
    required this.homeNavigatorKey,
    required this.orderNavigatorKey,
    required this.deliveryNavigatorKey,
    required this.profileNavigatorKey,
    required this.orderCanPop,
    required this.deliveryCanPop,
    required this.profileCanPop,
  });
  final GlobalKey<NavigatorState> homeNavigatorKey;
  final GlobalKey<NavigatorState> orderNavigatorKey;
  final GlobalKey<NavigatorState> deliveryNavigatorKey;
  final GlobalKey<NavigatorState> profileNavigatorKey;
  final String title;
  final int itemCount;
  final ValueNotifier<bool> homeCanPop;
  final ValueNotifier<bool> orderCanPop;
  final ValueNotifier<bool> deliveryCanPop;
  final ValueNotifier<bool> profileCanPop;
  final ValueNotifier<ActiveNavigator> activeNavigator;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
      leading: Builder(
        builder: (context) {
          /*
          final canPop =
              homeCanPop.value  ||
              orderCanPop.value; ||
              deliveryCanPop.value ||
              profileCanPop.value; // Navigator.of(context).canPop();
              */
              print("aciive value is ${activeNavigator.value}");
          final currentNavigator = switch (activeNavigator.value) {
            ActiveNavigator.home => homeNavigatorKey,
            ActiveNavigator.order => orderNavigatorKey,
            ActiveNavigator.delivery => deliveryNavigatorKey,
            ActiveNavigator.profile => profileNavigatorKey,
          };
          final canPop = currentNavigator.currentState?.canPop() ?? false;
          /*
          final canPop = switch (activeNavigator.value) {
            ActiveNavigator.home =>
              homeNavigatorKey.currentState?.canPop() ?? false,

            ActiveNavigator.order =>
              orderNavigatorKey.currentState?.canPop() ?? false,

            ActiveNavigator.delivery =>
              deliveryNavigatorKey.currentState?.canPop() ?? false,

            ActiveNavigator.profile =>
              profileNavigatorKey.currentState?.canPop() ?? false,
          };
          */
          print('i can pop: $canPop');
          if (canPop) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () {
               // Navigator.of(context).maybePop();
               currentNavigator.currentState?.maybePop();
              },
            );
          }

          return IconButton(
            icon: const Icon(Icons.menu),
            color: AppColors.textColor,
            tooltip: AppLocalizations.of(context)!.navigation_menu_tooltip,
            hoverColor: AppColors.selectionColor,
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
      ),
      /*
      leading: ValueListenableBuilder<bool>( 
        valueListenable: homeCanPop,
        builder: (context, homeCanPop, _) {
          if (homeCanPop) {
                 return IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.textColor,
            hoverColor: AppColors.selectionColor,
            onPressed: () {
              homenavigatorKey.currentState?.pop();
            },
          );
          }
            return Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    color: AppColors.textColor,
                    tooltip: AppLocalizations.of(context)!.navigation_menu_tooltip,
                    hoverColor: AppColors.selectionColor,
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
            );
        },
      ),
      */

      /*
      leading: Builder(
  builder: (context) {
    final isOrders = activeNavigator.value == ActiveNavigator.orders;

    final canPop = isOrders
        ? (orderNavigatorKey.currentState?.canPop() ?? false)
        : (homeNavigatorKey.currentState?.canPop() ?? false);

    if (canPop) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        color: AppColors.textColor,
        onPressed: () {
          if (isOrders) {
            orderNavigatorKey.currentState?.pop();
          } else {
            homeNavigatorKey.currentState?.pop();
          }
        },
      );
    }

    return IconButton(
      icon: const Icon(Icons.menu),
      color: AppColors.textColor,
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  },
),
      */
      backgroundColor: AppColors.backgroundColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () {
                Navigator.pushNamed(context, '/shopping');
              },
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.selectionColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$itemCount',
                  style: const TextStyle(
                    color: AppColors.backgroundColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            Navigator.pushNamed(context, '/notification');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

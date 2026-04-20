import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/screens/root_screen.dart';

class MoveguiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoveguiAppBar({
    super.key,
    required this.title,
    required this.itemCount,
    required this.homenavigatorKey,
    required this.homeCanPop,
    required this.onTitleChange,
    required this.activeNavigator,
  });
  final GlobalKey<NavigatorState> homenavigatorKey;
  final String title;
  final int itemCount;
  final ValueNotifier<bool> homeCanPop;
  final Function(String) onTitleChange;
  final ValueNotifier<ActiveNavigator> activeNavigator;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
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
      backgroundColor: AppColors.backgroundColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            homenavigatorKey.currentState?.pushNamed('/search');
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () {
                homenavigatorKey.currentState?.pushNamed('/shopping');
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
            homenavigatorKey.currentState?.pushNamed('/notification');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

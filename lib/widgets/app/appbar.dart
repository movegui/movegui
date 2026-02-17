import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/screens/auth/user_menu_screen.dart';

class MoveguiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoveguiAppBar({
    super.key,
    required this.title,
    required this.itemCount,
    required this.navigatorKey,
    required this.homeCanPop,
    required this.onTitleChange,
  });
  final GlobalKey<NavigatorState> navigatorKey;
  final String title;
  final int itemCount;
  final ValueNotifier<bool> homeCanPop;
  final Function(String) onTitleChange;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        color: AppColors.textColor,
        fontSize: 20,
      ),
      leading: ValueListenableBuilder<bool>(
        valueListenable: homeCanPop,
        builder: (context, canPop, _) {
          if (canPop) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () {         
                if (navigatorKey.currentState?.canPop() ?? false) {
                  navigatorKey.currentState?.pop();
                }   
                         
              },
            );
          } else {
            return Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    color: AppColors.textColor,
                    tooltip: 'Navigation menu',
                    hoverColor: AppColors.selectionColor,
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
            );
          }
        },
      ),
      backgroundColor: AppColors.backgroundColor, 
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            navigatorKey.currentState?.pushNamed('/search');
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            navigatorKey.currentState?.pushNamed('/notifation');
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/shopping');
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
        
        UserMenuScreen(
          navigatorKey: navigatorKey,
          onTitleChange: onTitleChange,
        //  observer: observer,
          barCanPop: homeCanPop,
        ),
        
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

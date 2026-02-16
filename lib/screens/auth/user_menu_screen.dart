import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/widgets/menu/menu_item_widget.dart';
import 'package:movegui/widgets/menu/menuitem.dart';

class UserMenuScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Function(String) onTitleChange;
  final NavigatorObserver observer;
  final ValueNotifier<bool> barCanPop;

  const UserMenuScreen({
    super.key,
    required this.navigatorKey,
    required this.onTitleChange,
    required this.observer,
    required this.barCanPop,
  });
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      offset: const Offset(0, 50), // Moves menu 20 pixels down from the icon
      icon: const Icon(
        Icons.person,
        // size: 50,
        color: Color(0xFFFFFFFF),
      ), //use this icon
      onSelected: (MenuItem item) {
        navigatorKey.currentState?.pushNamed(item.route);
      },
      color: AppColors.textColor,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.selectionColor),
      ),
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem(title: 'Login', route: '/login'),
              child: MenuItemWidget(title: 'Login', route: '/login'),
            ),
            const PopupMenuItem<MenuItem>(
              value: MenuItem(title: 'Enregistrer', route: '/register'),
              child: MenuItemWidget(title: 'Enregistrer', route: '/register'),
            ),
          ],
    );
  }
}

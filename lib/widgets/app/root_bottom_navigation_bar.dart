import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/services/assets_manager.dart';

class RootBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;

  const RootBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            );
          }
          return const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.normal,
          );
        }),
      ),
      child: NavigationBar(
        indicatorColor: Colors.transparent,
        selectedIndex: currentIndex,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: AppColors.selectionColor),
            icon: Icon(Icons.home, color: AppColors.textColor),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(
              AssetImage(AssetsManager.commandeIcon3),
              color: AppColors.selectionColor,
              size: 24,
            ),
            icon: ImageIcon(
              AssetImage(AssetsManager.commandeIcon3),
              color: AppColors.textColor,
            ),
            label: "Commande",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(
              AssetImage(AssetsManager.livraisonIcon3),
              color: AppColors.selectionColor,
            ),
            icon: ImageIcon(
              AssetImage(AssetsManager.livraisonIcon3),
              color: AppColors.textColor,
            ),
            label: "Livraison",
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(
              AssetImage(AssetsManager.reservationIcon3),
              color: AppColors.selectionColor,
            ),
            icon: ImageIcon(
              AssetImage(AssetsManager.reservationIcon3),
              color: AppColors.textColor,
              size: 24,
            ),
            label: "Courses",
          ),
        ],
      ),
    );
  }
}


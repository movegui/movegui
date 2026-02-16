import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/services/assets_manager.dart';


class AppFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double iconSize;

  const AppFooter({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.selectionColor,
      unselectedItemColor: AppColors.textColor,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon:Icon(Icons.home, color: AppColors.textColor, size: iconSize,),
        ),
        BottomNavigationBarItem(
          label: "Commande",
          icon: ImageIcon(
            AssetImage(AssetsManager.commandeIcon3), 
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: "Livraison",
          icon: ImageIcon(
            AssetImage(AssetsManager.livraisonIcon3),
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: "Courses",
          icon: ImageIcon(
            AssetImage(AssetsManager.reservationIcon3),
            size: iconSize,
          ),
        ),
      ],
    );
  }
}

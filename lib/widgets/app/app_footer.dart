import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
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
    final theme = Theme.of(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: theme.colorScheme.secondary,
      unselectedItemColor: AppColors.placeHolderText,
      items: [
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.home_title,
          icon:Icon(Icons.home, size: iconSize,),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.command_title,
          icon: ImageIcon(
            AssetImage(AssetsManager.commandeIcon3), 
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.delivery_title,
          icon: ImageIcon(
            AssetImage(AssetsManager.livraisonIcon3),
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.profile_title,
          icon: ImageIcon(
            AssetImage(AssetsManager.reservationIcon3),
            size: iconSize,
          ),
        ),
      ],
    );
  }
}

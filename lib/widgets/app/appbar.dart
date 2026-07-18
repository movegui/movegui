import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/providers.dart';


class MoveguiAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MoveguiAppBar({super.key, this.itemCount});
  final int? itemCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appbarTitleProviderState).title;
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 20),
      leading: Builder(
        builder: (context) {
          final canPop = context.canPop() || false;
          if (canPop) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () => context.pop(),
            );
          }

          final scaffold = Scaffold.maybeOf(context);
          final hasDrawer = scaffold?.widget.drawer != null;
          if (hasDrawer) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: AppColors.textColor,
              tooltip: AppLocalizations.of(context)!.navigation_menu_tooltip,
              hoverColor: AppColors.selectionColor,
              onPressed: () => scaffold?.openDrawer(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      
      backgroundColor: AppColors.backgroundColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: AppColors.textColor,
          hoverColor: AppColors.selectionColor,
          onPressed: () {
            context.push(RouteConstants.SEARCH_ROUTE);
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              color: AppColors.textColor,
              hoverColor: AppColors.selectionColor,
              onPressed: () {
                context.push(RouteConstants.SHOPPING_ROUTE);
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
            context.push(RouteConstants.NOTIFICATIONS_ROUTE);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

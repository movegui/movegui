import 'package:another_flushbar/flushbar.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/image_service.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/home/home_page_content_widget.dart';
import 'package:movegui/widgets/shared/widget_with_image.dart';
import 'package:movegui/widgets/util/category_image_banner.dart';
import 'package:movegui/widgets/util/tab_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.selectedTabIndex,
    this.onTabChange,
    this.currentScreen,
  });
  final bool isHorizontal = false;
  final int? selectedTabIndex;
  final int? currentScreen;
  final Function(int index)? onTabChange;

  @override
  State<StatefulWidget> createState() => HomescreenState();
}

class HomescreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(AppLocalizations.of(context)!.home_title);
    });
    */
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppbarTitleProvider>().setTitle(
        AppLocalizations.of(context)!.home_title,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Responsive.isDesktop(context) ? _buildDesktop() : _buildMobile();
  }

  Widget _buildMobile() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CategoryImageBanner(), HomePageContentWidget()],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktop() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildWebTabs(context),
            const SizedBox(height: 20),
            _builWebdCategoriesWidget(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

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
                selected: widget.selectedTabIndex == index,
                onTap: () {
                  setState(() {
                    widget.onTabChange!(index);
                    ImageService.onPressedCategoryImage(
                      context,
                      tab.routeName,
                      tab.title,
                      tab.enabled,
                    );
                  });
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

  Widget _builWebdCategoriesWidget(BuildContext context) {
    return DynamicHeightGridView(
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
          action: (context, routeName, title, enabled) async {
            await ImageService.onPressedCategoryImage(
              context,
              routeName,
              title,
              enabled,
            );
          },
          routeName:
              AppConstants.allCategoriesItems(
                AppLocalizations.of(context)!,
              )[index].routeName,
          enabled:
              AppConstants.allCategoriesItems(
                AppLocalizations.of(context)!,
              )[index].enabled,
        );
      },
      itemCount:
          AppConstants.allCategoriesItems(AppLocalizations.of(context)!).length,
      crossAxisCount: 5,
    );
  }
}

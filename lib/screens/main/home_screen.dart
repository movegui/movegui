import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/providers/theme_provider.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/home/home_page_content_widget.dart';
import 'package:movegui/widgets/util/category_image_banner.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onTitleChange});
  final Function(String) onTitleChange;
  final bool isHorizontal = false;

  @override
  State<StatefulWidget> createState() => HomescreenState();
}

class HomescreenState extends State<HomeScreen> with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(AppLocalizations.of(context)!.home_title);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoryImageBanner(),
                    HomePageContentWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

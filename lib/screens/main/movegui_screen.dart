import 'package:flutter/material.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/app/app_footer_web.dart';
import 'package:movegui/widgets/app/contact_widget.dart';
import 'package:movegui/widgets/movegui/movegui_mobile_image_widget.dart';
import 'package:movegui/widgets/movegui/movegui_social_icons_widget.dart';
import 'package:movegui/widgets/movegui/movegui_text_widget.dart';

class MoveguiScreen extends StatefulWidget {
  final Function(String) onTitleChange;
  const MoveguiScreen({super.key, required this.onTitleChange});

  @override
  State<StatefulWidget> createState() => MoveguiScreenState();
}

class MoveguiScreenState extends State<MoveguiScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTitleChange(TitleManager.moveguiTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoveguiMobileImageWidget(),
                  MoveguiTextWidget(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ContactWidget(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child:
                            Responsive.isMobile(context)
                                ? AppFooterWeb()
                                : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MoveguiSocialIconsWidget(),
          ],
        ),
      ),
    );
  }
}

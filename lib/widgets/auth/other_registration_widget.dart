import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/platform_widget.dart';
import 'package:movegui/widgets/auth/facebook_authentication.dart';
import 'package:movegui/widgets/auth/google_authentication.dart';
import 'package:movegui/widgets/subtitle_text.dart';

class OtherRegistrationWidget extends StatelessWidget {
  const OtherRegistrationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return 
          PlatformWidget.isAndroid(context) || PlatformWidget.isWeb(context)
              ? Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SubtitleTextWidget(
                    label:
                        AppLocalizations.of(
                          context,
                        )!.label_login_connect_using.toUpperCase(),
                        fontSize: WidgetConstants.subtitle_line,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: WidgetConstants.sepWidgetWidth),
                          child: FittedBox(child: GoogleAuthentication()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: WidgetConstants.sepWidgetWidth),
                          child: FittedBox(child: FacebookAuthentication()),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : SizedBox();
  }
}

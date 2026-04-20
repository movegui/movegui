import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/platform_widget.dart';
import 'package:movegui/widgets/auth/facebook_authentication.dart';
import 'package:movegui/widgets/auth/google_authentication.dart';
import 'package:movegui/widgets/subtitle_text.dart';

class OtherRegistrationWidget extends StatelessWidget {
  const OtherRegistrationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child:
          PlatformWidget.isAndroid(context) || PlatformWidget.isWeb(context)
              ? Column(
                children: [
                  SubtitleTextWidget(
                    label:
                        AppLocalizations.of(
                          context,
                        )!.label_login_connect_using.toUpperCase(),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(child: GoogleAuthentication()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(child: FacebookAuthentication()),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : null,
    );
  }
}

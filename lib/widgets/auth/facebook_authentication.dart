import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class FacebookAuthentication extends StatelessWidget {
  FacebookAuthentication({super.key});

  void _onPressed(BuildContext context, ButtonItem item) {
    if (!item.enabled)
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      buttonItem: ButtonItem(
        AppLocalizations.of(context)!.label_login_facebook,
        AppLocalizations.of(context)!.tooltip_sign_in_with_facebook,
        false,
        routeName: RouteContants.FACEBOOK_ROUTE,
      ),
      onPressed: (context, buttonItem) async {
        _onPressed(context, buttonItem);
      },
      icon: Ionicons.logo_facebook,
        fontSize: Responsive.isMobile(context) ? WidgetConstants.buttonFonsize * 1.8 : WidgetConstants.buttonFonsize * 2.3,
    );
  }
}

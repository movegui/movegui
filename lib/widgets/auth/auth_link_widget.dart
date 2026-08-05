import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class AuthLinkWidget extends StatefulWidget {
  final String? email;

  const AuthLinkWidget({super.key, this.email});
  @override
  State<StatefulWidget> createState() => AuthLinkWidgetState();
}

class AuthLinkWidgetState extends State<AuthLinkWidget> {
  void _onPressed(BuildContext context, ButtonItem item) {
    if (!item.enabled)
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    else {
      context.push(item.routeName!);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ButtonWidget(
              onPressed: (context, buttomItem) async {
                _onPressed(context, buttomItem);
              },
              buttonItem: ButtonItem(
                title:
                    AppLocalizations.of(context)!.label_login_forget_password,
                tooltipText:
                    AppLocalizations.of(context)!.tooltip_forget_password,
                enabled: true,
                routeName: RouteConstants.FORGET_PASSWORD_ROUTE,
              ),
              icon: Ionicons.key_outline,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: WidgetConstants.sepWidgetHeight,
              right: WidgetConstants.sepWidgetHeight,
            ),
            child: ButtonWidget(
              onPressed: (context, buttomItem) async {
                _onPressed(context, buttomItem);
              },
              buttonItem: ButtonItem(
                title: AppLocalizations.of(context)!.label_registration,
                tooltipText: AppLocalizations.of(context)!.tooltip_registration,
                enabled: true,
                routeName: RouteConstants.REGISTER_ROUTE,
              ),
              icon: Ionicons.person,
            ),
          ),
        ),
      ],
    );
  }
}

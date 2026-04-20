import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/providers/appbar_title_provider.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/util/button_widget.dart';
import 'package:provider/provider.dart';

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
      Navigator.pushNamed(
        context,
        item.routeName!,
        arguments: {'item': item, 'email': widget.email},
      );
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: WidgetConstants.sepWidgetHeight, right: WidgetConstants.sepWidgetHeight,),
          child: ButtonWidget(
            onPressed: (context, buttomItem) async {
              _onPressed(context, buttomItem);
            },
            buttonItem: ButtonItem(
              AppLocalizations.of(context)!.label_login_forget_password,
              AppLocalizations.of(context)!.tooltip_forget_password,
              true,
              routeName: RouteContants.FORGET_PASSWORD_ROUTE,
            ),
            icon: Ionicons.key_outline,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: WidgetConstants.sepWidgetHeight, right: WidgetConstants.sepWidgetHeight,),
          child: ButtonWidget(
            onPressed: (context, buttomItem) async {
              _onPressed(context, buttomItem);
            },
            buttonItem: ButtonItem(
              AppLocalizations.of(context)!.label_registration,
              AppLocalizations.of(context)!.tooltip_registration,
              true,
              routeName: RouteContants.REGISTER_ROUTE,
            ),
            icon: Ionicons.person,
          ),
        ),
      ],
    );
  }
}

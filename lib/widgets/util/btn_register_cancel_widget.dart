import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/widgets/auth/validation_button.dart';

class BtnRegisterCancelWidget extends StatelessWidget {
  final Future<void> Function(BuildContext context, ButtonItem item) actionFCT;
  final Future<void> Function(BuildContext context, ButtonItem item) cancelFCT;
  final String? actionTitle;
  final IconData? icon;
  final String? actionRouteName;
  final String? cancelRouteName;
  final bool? actionEnabled;

  BtnRegisterCancelWidget({
    required this.actionFCT,
    required this.cancelFCT,
     this.actionTitle =  null,
     this.icon = Icons.save,
     this.actionRouteName = '',
     this.cancelRouteName = '',
     this.actionEnabled = true

  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValidationButton(
            fn: actionFCT,
            buttonItem: ButtonItem(
              title:
                  actionTitle ??
                  AppLocalizations.of(context)!.btn_register_label,
              tooltipText: '',
              enabled: actionEnabled ??  true,
              routeName: actionRouteName ?? '',
            ),
            icon: icon,
          ),
        ),
        SizedBox(width: WidgetConstants.sepWidgetHeight),
        Expanded(
          child: ValidationButton(
            fn: cancelFCT,
            buttonItem: ButtonItem(
              title: AppLocalizations.of(context)!.btn_cancel,
              tooltipText: '',
              enabled: true,
              routeName: '',
            ),
            icon: Icons.cancel_outlined,
          ),
        ),
      ],
    );
  }
}

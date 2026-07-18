import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/widgets/auth/validation_button.dart';

class BtnRegisterCancelWidget extends StatelessWidget {
  final Function(BuildContext context, ButtonItem item) registerFCT;
  final Function(BuildContext context, ButtonItem item) cancelFCT;
  BtnRegisterCancelWidget({required this.registerFCT, required this.cancelFCT});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValidationButton(
            fn: (BuildContext context, ButtonItem item) {
              return registerFCT(context, item);
            },
            buttonItem: ButtonItem(
              title: AppLocalizations.of(context)!.btn_register_label,
              tooltipText: '',
              enabled: true,
              routeName: '',
            ),
          ),
        ),
        SizedBox(width: WidgetConstants.sepWidgetHeight),
        Expanded(
          child: ValidationButton(
            fn: (BuildContext context, ButtonItem item) {
              return cancelFCT(context, item);
            },
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

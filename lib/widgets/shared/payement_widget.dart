import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/services/assets_manager.dart';

class PayementWidget extends StatelessWidget {
  final Color? textColor;

  const PayementWidget({super.key, this.textColor = AppColors.textColor});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetsManager.cashIcon, width: 18, height: 18),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context)!.payement_cash,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ],
        ),
    SizedBox(width: 8,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetsManager.orangeIcon, width: 18, height: 18),
            const SizedBox(width: 6),
            Text("Orange", style: TextStyle(fontSize: 14, color: textColor)),
          ],
        ),

            SizedBox(width: 8,),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetsManager.ymoIcon, width: 18, height: 18),
            const SizedBox(width: 6),
            Text("YMO", style: TextStyle(fontSize: 14, color: textColor)),
          ],
        ),
        SizedBox(width: 12,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class ValidationButton extends StatelessWidget {
  final Future<void> Function(BuildContext context, ButtonItem item) fn;
  final ButtonItem buttonItem;
  final IconData? icon;

  const ValidationButton({super.key, required this.fn, required this.buttonItem, this.icon, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ButtonWidget(onPressed: fn, buttonItem: buttonItem, icon: icon)
            
            /*
             ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(6.0),
                backgroundColor: AppColors.backgroundColor,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              icon: const Icon(Icons.login, color: AppColors.textColor),
              label: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                ),
              ),
              onPressed: () async {
                await fn;
              },
            ),
*/
          ),
        ),
      ],
    );
  }
}

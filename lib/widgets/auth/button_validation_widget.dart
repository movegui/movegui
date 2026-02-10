
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';

class ButtonValidationWidget extends StatelessWidget {
  final String title;
  final Future<void> Function() onPress;
  final Icon? icon;

  const ButtonValidationWidget({super.key, required this.title, required this.onPress, this.icon,  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                  SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                backgroundColor: AppColors.backgroundColor,
                // backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              icon: icon, //const Icon(IconlyLight.addUser, color: AppColors.textColor, ),
              label:  Text(
                title,
                style: TextStyle(color: AppColors.textColor, fontSize: 28),
              ),
              onPressed: () async {
                  await onPress;
              },
            ),
          ),
      ],
    );
  }
  
}
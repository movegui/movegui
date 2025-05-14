import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui/consts/app_colors.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.all(6.0),
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: AppColors.textColor,
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(color: AppColors.textColor , fontSize: 14),
      ),
      onPressed: () async {},
    );
  }
}

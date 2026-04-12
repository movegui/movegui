import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';

class MoveguiSocialIconsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 2,
      top: MediaQuery.of(context).size.height * 0.2,
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildButton(Icons.facebook),
            _buildDivider(),
            _buildButton(Icons.tiktok),
            _buildDivider(),
            _buildButton(Icons.phone),
            _buildDivider(),
            _buildButton(Icons.telegram),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon) {
    return SizedBox(
      height: 60,
      width: 60,
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: AppColors.textColor),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: AppColors.textColor);
  }
}

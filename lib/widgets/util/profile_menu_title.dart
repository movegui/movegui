import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';

class ProfileMenuTitle extends StatelessWidget{

    final IconData icon;
    final String title;
    final VoidCallback? onTap;

  const ProfileMenuTitle({super.key, required this.icon, required this.title, this.onTap});
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: WidgetConstants.sepWidgetHeight * 2,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
  }

import 'package:flutter/material.dart';
import 'package:movegui/widgets/menu/menuitem.dart';

class UserMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      offset: const Offset(0, 50), // Moves menu 20 pixels down from the icon
      icon: const Icon(
        Icons.person,
        // size: 50,
        color: Color(0xFFFFFFFF),
      ), //use this icon
      onSelected: (MenuItem item) {
        Navigator.pushNamed(context, item.route);
        /*
              setState(() {
                    Navigator.pushNamed(context, item.route);
              });
              */
      },
      color: Color(0xFFFFFFFF),
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem(title: 'Login', route: 'login'),
              child: MenuItem(title: 'Login', route: 'login'),
            ),
            const PopupMenuItem<MenuItem>(
              value: MenuItem(title: 'Enregistrer', route: 'enregistrer'),
              child: MenuItem(title: 'Enregistrer', route: 'enregistrer'),
            ),
            /*
                  const PopupMenuItem<MenuItem>(
                    value: MenuItem(title: '3title3', route: 'route'),
                    child: Text('Item 3'),
                  ),
                  const PopupMenuItem<MenuItem>(
                    value: MenuItem(title: 'title4', route: 'route'),
                    child: Text('Item 4'),
                  ),
                  */
          ],
    );
  }
}

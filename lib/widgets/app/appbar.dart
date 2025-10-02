import 'package:flutter/material.dart';
import 'package:movegui/screens/auth/user_menu_screen.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/notification_screen.dart';
import 'package:movegui/screens/search_screen.dart';
import 'package:movegui/screens/shopping_cart_screen.dart';

class MoveguiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoveguiAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF), // Set the title color
        fontSize: 20,
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            color: Color(0xFFFFFFFF),
            tooltip: 'Navigation menu',
            onPressed: () {
              //  _showMenu(context);
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      backgroundColor: Color(0xFF871A1C), // Customize color
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.add_shopping_cart_outlined),
          color: Color(0xFFFFFFFF),
          onPressed: () {
            print('click on panier icon');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(),
                ),
              );
              
          },
        ),
        UserMenuScreen(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

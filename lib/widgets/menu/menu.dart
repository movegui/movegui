import 'package:flutter/material.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/menu/menu_item_widget.dart';
import 'package:movegui/widgets/menu/menuitem.dart';

class MoveGuiMenu extends StatelessWidget {
  const MoveGuiMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF871A1C),
              ),
              child: Text(
                'MoveGui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
                  ListTile(
              title: MenuItemWidget(title: TitleManager.homeTitle, route:'/'),
            ),
            ListTile(
              title: MenuItemWidget(title: TitleManager.reservationTitle,route: 'reservation'),
            ),
            ListTile(
              title: MenuItemWidget(title: TitleManager.commandTitle, route:'commande'),
            ),
              ListTile(
              title: MenuItemWidget(title: TitleManager.livraisonTitle, route:'to_deliver'),
            ),
               ListTile(
              title: MenuItemWidget(title: TitleManager.moveguiTitle, route:'movegui'),
            ),
           
          ],
        ),
      );
  }
  
}

class SocialMenu extends StatelessWidget {
  const SocialMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF871A1C),
              ),
              child: Text(
                'MoveGui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: MenuItemWidget(title: 'Facebook',route: 'facebook'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: MenuItemWidget(title: 'Instagramm', route:'instagramm'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      );
  }
  
}

class InfoMenu extends StatelessWidget {
  const InfoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF871A1C),
              ),
              child: Text(
                'MoveGui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: MenuItemWidget(title: 'Contact',route: 'contact'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: MenuItemWidget(title: 'AGB', route:'agb'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      );
  }
  
}

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF871A1C),
              ),
              child: Text(
                'MoveGui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: MenuItemWidget(title: 'Se Connecter',route: 'connect'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: MenuItemWidget(title: 'Deconnecter', route:'deconnecter'),
              onTap: () {
                // Handle item tap
              },
            ),
              ListTile(
              title: MenuItemWidget(title: 'Compte', route:'compte'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      );
  }
  
}

import 'package:flutter/material.dart';
import 'package:movegui/services/title_manager.dart';
import 'package:movegui/widgets/menuitem.dart';

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
              title: MenuItem(title: TitleManager.homeTitle, route:'/'),
            ),
            ListTile(
              title: MenuItem(title: TitleManager.reservationTitle,route: 'reservation'),
            ),
            ListTile(
              title: MenuItem(title: TitleManager.commandTitle, route:'commande'),
            ),
              ListTile(
              title: MenuItem(title: TitleManager.livraisonTitle, route:'to_deliver'),
            ),
               ListTile(
              title: MenuItem(title: TitleManager.moveguiTitle, route:'movegui'),
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
              title: MenuItem(title: 'Facebook',route: 'facebook'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: MenuItem(title: 'Instagramm', route:'instagramm'),
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
              title: MenuItem(title: 'Contact',route: 'contact'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: MenuItem(title: 'AGB', route:'agb'),
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
              title: MenuItem(title: 'Se Connecter',route: 'connect'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: MenuItem(title: 'Deconnecter', route:'deconnecter'),
              onTap: () {
                // Handle item tap
              },
            ),
              ListTile(
              title: MenuItem(title: 'Compte', route:'compte'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      );
  }
  
}

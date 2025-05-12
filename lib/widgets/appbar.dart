import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:movegui/screens/home_screen.dart';

class MoveguiAppBar extends StatelessWidget {
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
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(title: 'Search')));
                       
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(title: 'Notification',)));
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                          title: 'User',)));
            },
          ),
        ],
      ),
  }
  
}
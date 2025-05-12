import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget{
  const MenuItem({super.key, 
    required this.title,
    //required this.subtitle
    required this.route,
   });
   final String title;
   final String route;
   

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
       child: Card(
        color: Color(0xFF871A1C),
        margin: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(title: Text(title,
          style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),)
          ),
           
        ),
      ),
    );
  }
}


class FooterItem extends StatelessWidget{
  const FooterItem({super.key, 
    required this.title,
    //required this.subtitle
    required this.route,
   });
   final String title;
   final String route;
   

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
       child: Card(
        margin: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(title: Text(title)),
        ),
      ),
    );
  }
}
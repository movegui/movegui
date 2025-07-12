
import 'package:flutter/material.dart';
import 'package:movegui/screens/home_screen.dart';

class CategoryItem extends MoveguiWidgetImage {
  const CategoryItem({super.key, required super.title, required super.imagePath, required super.action, required super.index});

 
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(6),
      child: ElevatedButton(
          onPressed: () => action(context, index, title),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(),
            padding: EdgeInsets.all(1),
            backgroundColor: Color(0xFFFFFFFF),
            //  backgroundColor: Color(0xFF871A1C)
          ),
          child: Column(children: [
            Container(
                width: MediaQuery.of(context).size.width ,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  image: DecorationImage(
                    image: AssetImage(imagePath), // or NetworkImage
                    fit: BoxFit.fitHeight, // covers entire container
                    /*
                    colorFilter: ColorFilter.mode(
                      Color(
                          0xFF871A1C), // Change this to your desired color and opacity
                      BlendMode.color, // Other modes: overlay, multiply, etc.
                    ),
                    */
                  ),
                )),
            Container(
              color: Color(0xFF871A1C),
              padding: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      //   backgroundColor: Colors.black)
                    ),
                  )
                ],
              ),
            )
          ])),
    );
  }
  
}
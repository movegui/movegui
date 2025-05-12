import 'package:flutter/material.dart';
import 'package:movegui/screens/home_screen.dart';
import 'package:movegui/screens/reservation_screen.dart';
import 'package:movegui/screens/search_screen.dart';

class RestoScreen extends StatelessWidget{
  const RestoScreen({super.key});

  void _onPressedImage(BuildContext context, int index, String title) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen()));2
  }



  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(6),
      child: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              RestoItem(
                  title: 'Resto1',
                  imagePath: "assets/icons/moveguiB.jpg",
                  action: _onPressedImage,
                  index: 0,
                ),
                RestoItem(
                  title: 'Resto2',
                  imagePath: "assets/icons/moveguiB.jpg",
                  action: _onPressedImage,
                  index: 1,
                ),
                RestoItem(
                  title: 'Resto3',
                  imagePath: "assets/icons/moveguiB.jpg",
                  action: _onPressedImage,
                  index: 2,
                ),
                RestoItem(
                  title: 'Resto4',
                  imagePath: "assets/icons/moveguiB.jpg",
                  action: _onPressedImage,
                  index: 3,
                ),
                RestoItem(
                  title: 'Resto5',
                  imagePath: "assets/icons/moveguiB.jpg",
                  action: _onPressedImage,
                  index: 4,
                ),
        ],

      ),)
    );
  }
  
}

class RestoItem extends MoveguiWidgetImage {
  const RestoItem({super.key, required super.title, required super.imagePath, required super.action, required super.index});

 
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
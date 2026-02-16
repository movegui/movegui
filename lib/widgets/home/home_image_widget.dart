import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.action, required this.routeName,
  });
  final String title;
  final String imagePath;
  final Function(BuildContext context, String routeName, String title) action;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () => action(context, routeName, title),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          padding: EdgeInsets.all(1),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //  backgroundColor: Color(0xFF871A1C)
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.42,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
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
              ),
            ),
            Container(
              color: Color(0xFF871A1C),
              padding: EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width * 0.42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      //   backgroundColor: Colors.black)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
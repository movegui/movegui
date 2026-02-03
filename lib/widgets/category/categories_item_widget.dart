
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/categories_model.dart';
import 'package:movegui/screens/categories/patisserie_screen.dart';
import 'package:movegui/screens/categories/resto_screen.dart';

class CategoriesItemWidget extends StatelessWidget//extends MoveguiWidgetImage 
{
  final CategoriesModel model;
    CategoriesItemWidget({super.key, required this.model});
  final restaurantConstants = RestaurantConstants();
  final patisserieConstants = PatisserieConstants();


@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () => {
       if (model.name == restaurantConstants.getTitleName()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestoScreen(),
        ),
      ),
    } else if(model.name == patisserieConstants.getTitleName()){
            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatisserieScreen(),
        ),
      ),
    } 

      }, // Add your action here
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Section
          /*
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: NetworkImage(model.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          */

          // Text Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF871A1C),
                  ),
                ),
                SizedBox(height: 6),

                /*

                // Description
                Text(
                  model.description ?? "No description available.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),

                // Open Hours
                /*
                Row(
                  children: [
                    Icon(Icons.access_time, size: 18, color: Colors.grey[700]),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        model.openHours ?? "Open hours not available",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                */
                SizedBox(height: 4),

                // Address
                Row(
                  children: [
                    Icon(Icons.location_on, size: 18, color: Colors.grey[700]),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        model.adresse ?? "Address not available",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),

                // Contact
                Row(
                  children: [
                    Icon(Icons.phone, size: 18, color: Colors.grey[700]),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        model.contacts[0].name  ?? "Contact not available",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                */
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


/*
 
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(6),
      child: ElevatedButton(
          onPressed: () => {}, //action(context, index, title),
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
                    image:  NetworkImage(model.imageUrl),//AssetImage(model.imageUrl), // or NetworkImage
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
                    model.name,
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
  */
  
}
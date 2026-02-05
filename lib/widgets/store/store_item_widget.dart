import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/model.dart';
import 'package:movegui/models/open_hours_model.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/models/store_model.dart';
import 'package:movegui/screens/restos/resto_category_screnn.dart';

class StoreItem
    extends
        StatelessWidget //extends MoveguiWidgetImage
        {
  final StoreModel model;
  final int category;
  const StoreItem({super.key, required this.model, required this.category});

  void _onPressedImage(BuildContext context, int category, String title) {
    switch (category) {
      case AppConstants.CATEGORY_RESTAURANT:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RestoCategoryScreen()),
        );
        break;
    }
  }

  bool isOpen() {
    final now = DateTime.now();
    final int dayNumber = now.weekday;
    final today = AppConstants.daysOfWeek[dayNumber];
    int nowMinutes = -1;
    int openMinutes = -1;
    int closeMinutes = -1;
    model.weeklyHours.forEach((openDay) {
      if (openDay.day == today) {
        final now = TimeOfDay.now();

        nowMinutes = now.hour * 60 + now.minute;
        openMinutes = openDay.openTime!.hour * 60 + openDay.openTime!.minute;
        closeMinutes = openDay.closeTime!.hour * 60 + openDay.closeTime!.minute;
      }
    });

    return nowMinutes >= openMinutes && nowMinutes < closeMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final open = isOpen();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed:
            () => _onPressedImage(
              context,
              category,
              model.name,
            ), // Add your action here
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

            // Text Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 46, 2, 3),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        open ? 'OUVERT' : 'FERME',
                        style: TextStyle(
                          color: open ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),

                  // Description
                  Text(
                    model.description ?? "No description available.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
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

                  // Contact
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6),
                                Text(
                                  model.contacts[0].name ??
                                      "Contact not available",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.car_crash_rounded,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Ramassage & livraison",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
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
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "48h maximum",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Address
                  SizedBox(height: 4),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    model.contacts[0].phone ??
                                        "phone not available",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  size: 18,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "Paiement cash ou Orange Money",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/store_model.dart';
import 'package:movegui/screens/pressing/pressing_detail_screen.dart';
import 'package:movegui/screens/restos/resto_category_screnn.dart';
import 'package:movegui/services/assets_manager.dart';

class StoreItem extends StatelessWidget {
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
      case AppConstants.CATEGORY_PRESSING:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    PressingDetailScreen(model: model as PressingModel),
          ),
        );
        break;
    }
  }

  bool isPressing() {
    return category == AppConstants.CATEGORY_PRESSING;
  }

  bool isOpen() {
    final now = DateTime.now();
    final int dayNumber = now.weekday;
    final today = AppConstants.daysOfWeek[dayNumber - 1];
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
            //  isOpen() ?
            () async => _onPressedImage(
              context,
              category,
              model.name,
            ), //:null, // Add your action here
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
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        open
                            ? AppLocalizations.of(context)!.store_open
                            : AppLocalizations.of(context)!.store_closed,
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
                  SizedBox(height: 6),

                  /*
                  Row(
                    children: [
                      isPressing()
                          ? Text(
                            isPressing() ? "À partir de 5 000 GNF / vêtement" : "",
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          )
                          : SizedBox(height: 8),
                    ],
                  ),
                  */

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
                  Row(
                    children: [
                      Text(
                        model.description ?? "No description available.",
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

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
                                  model.staff[0].personModel?.name ??
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
                                  isPressing()
                                      ? AppLocalizations.of(
                                        context,
                                      )!.collect_delivery
                                      : AppLocalizations.of(context)!.delivery,
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
                                    model.address.address ??
                                        "Address not available",
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
                                    isPressing()
                                        ? AppLocalizations.of(
                                          context,
                                        )!.max_delivery_time
                                        : AppLocalizations.of(
                                          context,
                                        )!.fast_and_efficient,
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
                                    model.staff[0].personModel?.phone ??
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
                        child:
                            isPressing()
                                ? Text(
                                  isPressing()
                                      ? "À partir de 5 000 GNF / vêtement"
                                      : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                )
                                : SizedBox(height: 8),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AssetsManager.cashIcon,
                                          width: 28,
                                          height: 28,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Cash on Delivery",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AssetsManager.orangeIcon,
                                          width: 28,
                                          height: 28,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Orange Money",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                /*
                                                                            SizedBox(width: 6),
                                                                            
                                                                            Image.asset(
                                                                              AssetsManager.paypalIcon,
                                                                              width: 28,
                                                                              height: 28,
                                                                            ),
                                                                            SizedBox(width: 6),
                                                                            Image.asset(
                                                                              AssetsManager.masterCardIcon,
                                                                              width: 28,
                                                                              height: 28,
                                                                            ),
                                                                            */
                                SizedBox(width: 6),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AssetsManager.ymoIcon,
                                          width: 28,
                                          height: 28,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Mobile Money",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                /*
                                                                                  Text(
                                            "Paiement cash ou Orange Money",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                                                                  ),
                                                                                  */
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                        backgroundColor: AppColors.backgroundColor,
                        // backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      icon: const Icon(
                        IconlyLight.send,
                        color: AppColors.textColor,
                      ),
                      label: const Text(
                        "Commander Maintenant",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 18,
                        ),
                      ),
                      onPressed:
                          isOpen()
                              ? () async {
                                _onPressedImage(context, category, model.name);
                              }
                              : null,
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

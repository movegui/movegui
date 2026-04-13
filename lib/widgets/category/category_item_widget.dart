import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/l10n/app_localizations_en.dart';
import 'package:movegui/widgets/home/home_image_widget.dart';

class CategoryItemWidget extends ImageWidget {
  const CategoryItemWidget({
    super.key,
    required super.title,
    required super.imagePath,
    required super.action,
    required super.routeName,
    required super.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () => action(context, routeName, title, enabled),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          padding: EdgeInsets.all(1),
          backgroundColor: Color(0xFFFFFFFF),
          //  backgroundColor: Color(0xFF871A1C)
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
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
              ),
            ),
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
                  ),
                ],
              ),
            ),
            if (!enabled)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  AppLocalizations.of(context)!.deactivate_button_attach_message,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

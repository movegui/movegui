import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';

class MoveguiTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.movegui_info_title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF871A1C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  bottom: 8.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.movegui_info_text_1,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 44.0,
                  bottom: 8.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.movegui_info_text_2,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 44.0,
                  bottom: 0.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.movegui_info_text_3,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.6,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

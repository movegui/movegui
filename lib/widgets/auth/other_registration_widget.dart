import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/widgets/auth/google_btn.dart';
import 'package:movegui/widgets/subtitle_text.dart';

class OtherRegistrationWidget extends StatelessWidget {
  const OtherRegistrationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                        SubtitleTextWidget(label: "Or connect using".toUpperCase()),
                const SizedBox(height: 4.0),
                SizedBox(
                  //     height: kBottomNavigationBarHeight + 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(child: GoogleButton()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(6.0),
                            backgroundColor: AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            "Invite ?",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {},
                        ),
                      ),
                    ],
                  ),
                ),
      ],
    );
  }
}
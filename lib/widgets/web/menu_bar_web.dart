import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/l10n/app_localizations_en.dart';

class MenuBarWeb extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => MenuBarWebState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MenuBarWebState extends State<MenuBarWeb> {
  final loginConstatnts = LoginConstatnts();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: AppColors.backgroundColor,
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                child:        const Text(
              AppConstants.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
                onPressed: () async {
                   Navigator.pushNamed(context, '/home');
                },
              ),
            ),
      
            const SizedBox(width: 50),
            const Icon(Icons.location_on, color: AppColors.textColor),
            const Text(AppConstants.Adresse, style: TextStyle(color: AppColors.textColor),),
            const SizedBox(width: 80),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                     AppLocalizations.of(context)!.search,
                      style: const TextStyle(color: Colors.grey, ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 100),
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
                child:  Text(
                  loginConstatnts.getLoginTitle(),
                  style: TextStyle(color: AppColors.textColor, fontSize: 14),
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, '/login');
                },
              ),
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
                child:  Text(
                  loginConstatnts.getRegisterTitle(),
                  style: TextStyle(color: AppColors.textColor, fontSize: 14),
                ),
                onPressed: () async {
                   Navigator.pushNamed(context, '/register');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

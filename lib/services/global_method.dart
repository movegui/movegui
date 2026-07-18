import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/widgets/util/display_widget.dart';
import 'package:movegui/widgets/util/text_widget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    // Navigator.pushNamed(ctx, routeName);
    ctx.pushNamed(routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: TextWidget(
                color: Colors.cyan,
                text: 'Cancel',
                textSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                fct();
              },
              child: TextWidget(color: Colors.red, text: 'OK', textSize: 18),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showUserBottomSheet({
    required BuildContext context,
    required UserModel model,
  }) async {
    String birthdateFormat = '';

    if (model.personModel!.birthDate != null) {
      birthdateFormat = DateFormat(
        'dd-mm-yyyy',
      ).format(model.personModel!.birthDate!);
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                CircleAvatar(
                  radius: Responsive.isDesktop(context) ? 80 : 50,
                  backgroundImage: NetworkImage(
                    model.personModel?.profileImageUrl ??
                        'assets/images/profile/default_avatar.jpg',
                  ),
                ),

                const SizedBox(height: 10),

                DisplayWidget(
                  text: model.personModel?.name ?? 'MoveGui',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DisplayWidget(
                      text: birthdateFormat,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.left,
                    ),

                    DisplayWidget(
                      text: AppConstants.getGender(
                        model.personModel!.gender,
                        context,
                      ),
                      textAlign: TextAlign.right,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                ListTile(
                  leading: Icon(Icons.mail),
                  title: DisplayWidget(
                    text:
                        model.personModel?.email ??
                        AppLocalizations.of(context)!.no_email,
                    textAlign: TextAlign.left,
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.phone),
                  title: DisplayWidget(
                    text:
                        model.personModel?.phone ??
                        AppLocalizations.of(context)!.no_phone_number,
                    textAlign: TextAlign.left,
                  ),
                ),

                ListTile(
                  leading: Icon(
                    Icons.work,
                    color:
                        model.isActive
                            ? Color.fromARGB(255, 13, 197, 19)
                            : Colors.red,
                  ),
                  title: Text(
                    model.isActive
                        ? AppLocalizations.of(context)!.status_actf
                        : AppLocalizations.of(context)!.status_non_actf,
                    style: TextStyle(
                      color:
                          model.isActive
                              ? Color.fromARGB(255, 13, 197, 19)
                              : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/store_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/screens/restos/resto_category_screnn.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/shared/payement_widget.dart';

class StoreItemWidget extends ConsumerWidget {
  final StoreModel model;
  final int category;
  final Color? textColor;
  final Color? backgroundColor;
  const StoreItemWidget({
    super.key,
    required this.model,
    required this.category,
    this.textColor = AppColors.textColor,
    this.backgroundColor = AppColors.backgroundColor,
  });
  void _onPressedImage(
    BuildContext context,
    WidgetRef ref,
    int category,
    String title,
  ) {
    switch (category) {
      case AppConstants.CATEGORY_RESTAURANT:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RestoCategoryScreen()),
        );
        break;
      case AppConstants.CATEGORY_PRESSING:
        ref.read(storeProviderState).setStore(model);
        context.push(
          '${RouteConstants.HOME_ROUTE}${RouteConstants.PRESSING_ROUTE}${RouteConstants.PRESSING_DETAILS_ROUTE}/${model.id}',
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
  Widget build(BuildContext context, WidgetRef ref) {
    final open = isOpen();

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        onPressed:
            () async => _onPressedImage(context, ref, category, model.name),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          elevation: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            /*
            Container(
              height: 180,
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
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(model.imageUrl ?? ''),
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          model.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 10,
                          child: Icon(
                            Icons.circle,
                            size: 12, // smaller size for status
                            color: open ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.description ?? "No description available.",
                        style: TextStyle(fontSize: 16, color: textColor),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  SizedBox(height: 4),
                  // open Hours
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  open ? Icons.access_time : Icons.lock,
                                  size: 12, // smaller size for status
                                  color: open ? Colors.green : Colors.red,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  open
                                      ? AppLocalizations.of(context)!.store_open
                                      : AppLocalizations.of(
                                        context,
                                      )!.store_closed,
                                  style: TextStyle(
                                    color: open ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
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
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      index <
                                              (model.reviewCount > 0
                                                  ? model.rating /
                                                      model.reviewCount
                                                  : model.rating)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: open ? Colors.green : Colors.red,
                                      size: 16,
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

                  //       SizedBox(height: 4),

                  // Contact
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, size: 18, color: textColor),
                                SizedBox(width: 6),
                                Text(
                                  model.staff[0].personModel?.name ??
                                      "Contact not available",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor,
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
                                  color: textColor,
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
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //       SizedBox(height: 4),
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
                                  color: textColor,
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    model.address.address ??
                                        "Address not available",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
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
                                Icon(Icons.timer, size: 18, color: textColor),
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
                                      color: textColor,
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
                  //          SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone, size: 18, color: textColor),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    model.staff[0].personModel?.phone ??
                                        "phone not available",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
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
                                      ? AppLocalizations.of(
                                        context,
                                      )!.payement_from
                                      : "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                )
                                : SizedBox(height: 8),
                      ),
                    ],
                  ),
                  PayementWidget(),

                  //      SizedBox(height: 8),
                  ValidationButton(
                    fn: (context, item) async {
                      _onPressedImage(context, ref, category, model.name);
                    },
                    buttonItem: ButtonItem(
                      open
                          ? AppLocalizations.of(context)!.order_now
                          : AppLocalizations.of(context)!.order_after,
                      AppLocalizations.of(context)!.tooltip_btn_order,
                      true,
                      routeName: RouteConstants.PRESSING_DETAILS_ROUTE,
                    ),
                    icon: Icons.shopping_cart,
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

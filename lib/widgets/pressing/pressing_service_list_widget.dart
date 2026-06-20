import 'package:flutter/material.dart';

import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/widgets/price_total_widget.dart';
import 'package:movegui/widgets/util/display_widget_title.dart';

class PressingServiceListWidget extends StatefulWidget {
  final List<PressingServiceModel> actuelServices;
  final PressingServiceTypeModel serviceType;
  final String currency;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectionColor;
  final List<int> qtys;
  final double total;
  final Future<void> Function(int index) addQuantities;
  final Future<void> Function(int index) reduceQuantities;

  const PressingServiceListWidget({
    Key? key,
    required this.actuelServices,
    required this.serviceType,
    required this.currency,
    required this.addQuantities,
    required this.reduceQuantities,
    required this.qtys,
    required this.total,
    required this.backgroundColor,
    required this.textColor,
    required this.selectionColor,
  });

  @override
  State<PressingServiceListWidget> createState() =>
      PressingServiceListWidgetState();
}

class PressingServiceListWidgetState extends State<PressingServiceListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.actuelServices.length,
          itemBuilder: (context, index) {
            final item = widget.actuelServices[index];
            final qty = index < widget.qtys.length ? widget.qtys[index] : 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(item.article.name, style: TextStyle(color: widget.backgroundColor),)),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color:
                              qty > 0
                                  ? widget.backgroundColor
                                  : AppColors.disabled,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8),
                          child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 14,
                              color:
                                  qty > 0
                                      ? widget.textColor
                                      : AppColors.darkScaffoldColor,
                            ),
                            onPressed:
                                qty > 0
                                    ? () => setState(() {
                                      if (widget.qtys[index] > 0) {
                                        widget.reduceQuantities(index);
                                      }
                                    })
                                    : null,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(qty.toString()),
                        SizedBox(width: 8),
                        Material(
                          color: widget.backgroundColor,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(8),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 14,
                              color: widget.textColor,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.addQuantities(index);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Prix
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${((item.basePrice ?? 0) * qty).toInt()} ${widget.currency}',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: widget.backgroundColor)
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(thickness: 0.5),
        // _buildTotal(),
        PriceTotalWidget(
          total: widget.total,
          currency: widget.currency,
          title: 'SUB TOTAL',
          backgroundColor: widget.textColor,
          textColor: widget.backgroundColor,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: DisplayWidgetTitle(
              text:
                  AppLocalizations.of(context)!.pressing_service_article_title,
              textAlign: TextAlign.start,
              textColor: widget.backgroundColor,
              backgroundColor: widget.textColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: DisplayWidgetTitle(
                text:
                    AppLocalizations.of(context)!.pressing_service_article_qty,
                textColor: widget.backgroundColor,
                backgroundColor: widget.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: DisplayWidgetTitle(
              text:
                  AppLocalizations.of(context)!.pressing_service_article_price,
              textAlign: TextAlign.end,
              textColor: widget.backgroundColor,
              backgroundColor: widget.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

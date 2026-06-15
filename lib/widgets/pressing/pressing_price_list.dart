import 'package:flutter/material.dart';

import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/widgets/util/display_widget_title.dart';

class PressingPriceList extends StatefulWidget {
  final List<PressingServiceModel> allServices;
  final PressingServiceTypeModel serviceType;
  final String? currency;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectionColor;
  final Future<void> Function(
    List<PressingServiceModel> services,
    List<int> qtys,
  )
  onServicesChanged;
  const PressingPriceList({
    Key? key,
    required this.allServices,
    required this.serviceType,
    this.currency = 'GNF',
    required this.onServicesChanged,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.textColor,
    this.selectionColor = AppColors.selectionColor,
  });

  @override
  State<PressingPriceList> createState() => _PressingPriceListState();
}

class _PressingPriceListState extends State<PressingPriceList> {
  final List<PressingServiceModel> actuelServices = [];
  List<int> qtys = [];
  bool _initialized = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      await initServices();
      widget.onServicesChanged.call(actuelServices, qtys);
    }
  }

  Future<void> initServices() async {
    if (mounted) {
      actuelServices.clear();
      actuelServices.addAll(
        widget.allServices
            .where((service) => service.serviceType == widget.serviceType)
            .toList(),
      );
      qtys = List<int>.filled(actuelServices.length, 0);

      setState(() {});
    }
  }

  int get total {
    int sum = 0;
    for (var i = 0; i < actuelServices.length; i++) {
      final service = actuelServices[i];
      final qty = i < qtys.length ? qtys[i] : 0;
      final pricePerUnit = (service.basePrice ?? 0);
      sum += (pricePerUnit * qty).toInt();
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),

        const Divider(),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actuelServices.length,
          itemBuilder: (context, index) {
            final item = actuelServices[index];
            final qty = index < qtys.length ? qtys[index] : 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  // Service
                  Expanded(flex: 3, child: Text(item.article.name)),

                  // Quantité
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
                            icon:  Icon(
                              Icons.remove,
                              size: 14,
                              color: qty > 0 ? widget.textColor : AppColors.darkScaffoldColor,
                            ),
                            onPressed:
                                qty > 0
                                    ? () => setState(() {
                                      if (qtys[index] > 0) qtys[index]--;
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
                            icon:  Icon(
                              Icons.add,
                              size: 14,
                              color: widget.textColor,
                            ),
                            onPressed: () => setState(() => qtys[index]++),
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
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const Divider(thickness: 0.5),

        _buildTotal(),
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
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: DisplayWidgetTitle(
                text:
                    AppLocalizations.of(context)!.pressing_service_article_qty,
                textColor: widget.backgroundColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: DisplayWidgetTitle(
              text:
                  AppLocalizations.of(context)!.pressing_service_article_price,
              textAlign: TextAlign.end,
              textColor: AppColors.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotal() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          const Expanded(
            flex: 5,
            child: DisplayWidgetTitle(
              text: 'TOTAL',
              textAlign: TextAlign.left,
              textColor: AppColors.backgroundColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            flex: 2,
            child: DisplayWidgetTitle(
              text: '$total ${widget.currency}',
              textAlign: TextAlign.end,
              textColor: AppColors.backgroundColor,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

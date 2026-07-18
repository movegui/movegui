import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/models/pressing/pressing_order_model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/pressing/pressing_service_list_widget.dart';
import 'package:movegui/widgets/price_total_widget.dart';
import 'package:movegui/widgets/util/display_widget_title.dart';

class OrderPressingServiceListWidget extends StatefulWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final PressingOrderModel order;
  final void Function(int index) addQuantities;
  final void Function(int index) reduceQuantities;
  final void Function(int index) removeService;

  const OrderPressingServiceListWidget({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.order,
    required this.addQuantities,
    required this.reduceQuantities,
    required this.removeService,
  });

  @override
  State<StatefulWidget> createState() => OrderPressingServiceListWidgetState();
}

class OrderPressingServiceListWidgetState
    extends State<OrderPressingServiceListWidget> {
  late PressingService pressingService;
  Map<String, List<PressingServiceModel>> orderedServices = {};
  Map<String, List<int>> orderedQtys = {};
  bool _initialized = false;
  Set<PressingServiceTypeModel> serviceTypes = {};
  Map<String, double> servicesSubTotal = {};

  @override
  void initState() {
    pressingService = getIt<PressingService>();
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;
      await initServicesType();
      await initServices();
      await initQtys();
      await initSubTotal();
    }
  }

  Future<void> initSubTotal() async {
    Map<String, double> tempSubTotal = {};

    for (final type in serviceTypes) {
      final total = widget.order.items
          .where((item) => item.service.serviceType.id == type.id)
          .fold<double>(
            0,
            (sum, item) => sum + (item.qty * (item.service.basePrice ?? 0)),
          );

      tempSubTotal[type.id] = total;
    }

    setState(() {
      servicesSubTotal = tempSubTotal;
    });
  }

  Future<void> initServicesType() async {
    serviceTypes = widget.order.items.map((e) => e.service.serviceType).toSet();
  }

  Future<void> initServices() async {
    final Map<String, List<PressingServiceModel>> tempOrderedServices = {};
    for (final type in serviceTypes) {
      final services =
          widget.order.items
              .where((item) => item.service.serviceType == type)
              .map((item) => item.service)
              .toList();
      tempOrderedServices[type.id] = services;
    }
    setState(() {
      orderedServices = tempOrderedServices;
    });
  }

  Future<void> initQtys() async {
    final Map<String, List<int>> tempOrderedQtys = {};
    for (final type in serviceTypes) {
      final qtys =
          widget.order.items
              .where((item) => item.service.serviceType == type)
              .map((item) => item.qty)
              .toList();

      tempOrderedQtys[type.id] = qtys;
    }
    orderedQtys = tempOrderedQtys;
    setState(() {
      orderedQtys = tempOrderedQtys;
    });
  }

  @override
  Widget build(BuildContext context) {
    return orderedServices.isNotEmpty
        ? Padding(
          padding: EdgeInsetsGeometry.all(2),
          child: Column(
            children: [
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceTypes.length,
                itemBuilder: (context, index1) {
                  final serviceType = serviceTypes.toList()[index1];
                  final services = orderedServices[serviceType.id]!;
                  return Card(
                    color: widget.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DisplayWidgetTitle(
                            text: serviceType.name,
                            textAlign: TextAlign.start,
                            textColor: widget.textColor,
                            backgroundColor: widget.backgroundColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PressingServiceListWidget(
                              key: UniqueKey(),
                              actuelServices: [...services],
                              serviceType: serviceType,
                              addQuantities: (int index) async {
                                setState(() {
                                  ++orderedQtys[serviceType.id]![index];
                                  servicesSubTotal[serviceType.id] =
                                      servicesSubTotal[serviceType.id]! +
                                      widget
                                          .order
                                          .items[index]
                                          .service
                                          .basePrice!;
                                  widget.addQuantities.call(index);
                                });
                              },
                              reduceQuantities: (int index) async {
                                setState(() {
                                  if (orderedQtys[serviceType.id]![index] >
                                      0) {
                                    --orderedQtys[serviceType.id]![index];
                                    servicesSubTotal[serviceType.id] =
                                        servicesSubTotal[serviceType.id]! -
                                        widget
                                            .order
                                            .items[index]
                                            .service
                                            .basePrice!;
                                    widget.reduceQuantities.call(index);
                                  }
                                });
                              },
                              qtys: orderedQtys[serviceType.id]!,
                              currency: widget.order.currency,
                              total: servicesSubTotal[serviceType.id]!,
                              backgroundColor: AppColors.backgroundColor,
                              textColor: AppColors.textColor,
                              selectionColor: AppColors.selectionColor,
                            ),
                          ),
                          //     const Divider(thickness: 0.5),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              PriceTotalWidget(
                total: widget.order.total,
                currency: widget.order.currency,
                backgroundColor: widget.backgroundColor,
                textColor: widget.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ],
          ),
        )
        : SizedBox();
  }
}

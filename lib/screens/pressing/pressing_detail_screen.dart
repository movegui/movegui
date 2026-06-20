import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/pricing_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/remote_config_service.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/pressing/pressing_service_list_widget.dart';
import 'package:movegui/widgets/pressing/pressing_service_type_picker.dart';
import 'package:movegui/widgets/price_total_widget.dart';

class PressingDetailScreen extends ConsumerStatefulWidget {
  final String pressingId;

  const PressingDetailScreen({super.key, required this.pressingId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PressingDetailScreenState();
}

class PressingDetailScreenState extends ConsumerState<PressingDetailScreen> {
  late PressingService pressingService;
  late PricingService pricingService;
  final pressingConstants = PressingConstants();
  PressingModel? model;
  Set<PressingServiceTypeModel> serviceTypes = {};
  List<PressingServiceModel> services = [];
  PressingServiceTypeModel? serviceType;
  bool _initialized = false;
  List<int> selectedQtys = [];
  List<PressingServiceModel> selectedServices = [];
  Map<String, List<int>> orderedQtys = {};
  Map<String, List<PressingServiceModel>> orderedServices = {};
  double totlaServices = 0;
  double totalPerService = 0;

  @override
  void initState() {
    pressingService = getIt<PressingService>();
    pricingService = getIt<PricingService>();
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      await initModel();
      await RemoteConfigService.init();
    }
  }

  Future<void> createOrder(BuildContext context, ButtonItem item) async {}
  Future<void> addToCart(BuildContext context, ButtonItem item) async {}
  Future<void> callMovegui(BuildContext context, ButtonItem item) async {
    pressingService.callNumber(model!.phone);
  }

  Future<void> getActuelServices(
    PressingServiceTypeModel? selectedServiceType,
  ) async {
    if (mounted) {
      selectedServices.clear();
      selectedServices.addAll(
        services
            .where((service) => service.serviceType == selectedServiceType)
            .toList(),
      );
      setState(() {});
    }
  }

  Future<void> initModel() async {
    final store = ref.watch(storeProviderState);
    model = store.store as PressingModel?;
    if (model == null) {
      model = await pressingService.getModelById(widget.pressingId);
      store.setStore(model!);
    }

    if (mounted) {
      services = await pressingService.getAllServices(model!.id);
      if (services.isNotEmpty) {
        serviceType = services[0].serviceType;
      }

      for (PressingServiceModel serviceModel in services) {
        serviceTypes.add(serviceModel.serviceType);
        await getActuelServices(serviceModel.serviceType);
        orderedQtys[serviceModel.serviceType.id] = List<int>.filled(
          selectedServices.length,
          0,
        );
        orderedServices[serviceModel.serviceType.id] = [];
      }
      setState(() {});
    }
  }

  Future<double> CalculatePrice(
    double distanceKm,
    int items,
    double orderAmount,
    bool isExpress,
  ) async {
    return pricingService.calculate(
      distanceKm: distanceKm,
      items: items,
      orderAmount: orderAmount,
      isExpress: isExpress,
    );
  }

  int totalQte(List<int> qtys) {
    return qtys.fold(0, (sum, qty) => sum + qty);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return Material(
        color: Colors.transparent,
        child: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return Material(
      color: Colors.transparent, // or Colors.white
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //  ImageBanner(),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(model!.imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    model?.name ?? "Pressing Detail",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 145, 8, 10),
                    ),
                  ),
                  Text(
                    model?.description ?? "No description available.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 6),

                  if (serviceTypes.isNotEmpty)
                    PressingServiceTypePicker(
                      serviceType: serviceType,
                      onServiceTypeChanged: (
                        PressingServiceTypeModel? value,
                      ) async {
                        setState(() {
                          serviceType = value;
                          selectedServices.clear();
                        });
                        await getActuelServices(value);
                        final totalSelectedService = await pressingService
                            .getTotal(
                              selectedServices,
                              orderedQtys[serviceType!.id]!,
                            );
                        setState(() {
                          orderedServices[serviceType!.id] = selectedServices;
                          totalPerService = totalSelectedService;
                        });
                      },
                      model: model!,
                      serviceTypes: serviceTypes.toList(),
                    ),
                  SizedBox(height: 6),
                  serviceType != null
                      ? PressingServiceListWidget(
                        key: UniqueKey(),
                        actuelServices: selectedServices,
                        serviceType: serviceType!,
                        addQuantities: (int index) async {
                          setState(() {
                            ++orderedQtys[serviceType!.id]![index];

                            totalPerService +=
                                selectedServices[index].basePrice!;
                            totlaServices += selectedServices[index].basePrice!;
                          });
                        },
                        reduceQuantities: (int index) async {
                          setState(() {
                            if (orderedQtys[serviceType!.id]![index] > 0) {
                              totalPerService -=
                                  selectedServices[index].basePrice!;
                              --orderedQtys[serviceType!.id]![index];
                              totlaServices -=
                                  selectedServices[index].basePrice!;
                            }
                          });
                        },
                        qtys: orderedQtys[serviceType!.id]!,
                        currency: pressingService.getCureency(),
                        total: totalPerService,
                        backgroundColor: AppColors.backgroundColor,
                        textColor: AppColors.textColor,
                        selectionColor: AppColors.selectionColor,
                      )
                      : SizedBox(),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.pressing_detail_text_1,
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    AppLocalizations.of(context)!.pressing_detail_text_2,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 6),
                  Card(
                    color: AppColors.backgroundColor,
                    child: PriceTotalWidget(
                      total: totlaServices,
                      currency: pressingService.getCureency(),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  serviceType != null
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ValidationButton(
                              fn: (context, item) async {
                                if (item.enabled) {
                                  await createOrder(context, item);
                                } else {
                                  MessageWidget.errorMessage(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!.error_order_minimum_title,
                                    AppLocalizations.of(
                                      context,
                                    )!.error_order_minimum_message,
                                    Icon(Icons.error, color: AppColors.error),
                                    FlushbarPosition.BOTTOM,
                                  );
                                }
                              },
                              buttonItem: ButtonItem(
                                AppLocalizations.of(context)!.btn_order_label,
                                AppLocalizations.of(context)!.tooltip_btn_order,
                                totlaServices > 0 ? true : false,
                                routeName: '',
                              ),
                              padding: 12,
                              fontSize: 14,
                              icon: Icons.receipt_long,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: ValidationButton(
                              fn: (context, item) async {
                                await callMovegui(context, item);
                              },
                              buttonItem: ButtonItem(
                                AppLocalizations.of(context)!.btn_add_cart,
                                AppLocalizations.of(
                                  context,
                                )!.tooltip_btn_add_cart,
                                totlaServices > 0 ? true : false,
                                routeName: '',
                              ),
                              padding: 12,
                              fontSize: 14,
                              icon: Icons.add_shopping_cart,
                            ),
                          ),
                        ],
                      )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

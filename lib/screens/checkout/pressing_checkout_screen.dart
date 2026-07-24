import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/order_item_model.dart';
import 'package:movegui/models/pressing/pressing_order_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/models/pricing_config_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/services/form_services/adress_form_service.dart';
import 'package:movegui/services/localisation_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/checkout/checkout_adress_widget.dart';
import 'package:movegui/widgets/checkout/checkout_order_items_widget.dart';
import 'package:movegui/widgets/checkout/checkout_transport_widget.dart';
import 'package:movegui/widgets/order/order_info.dart';
import 'package:movegui/widgets/util/btn_register_cancel_widget.dart';
import 'package:movegui/widgets/support/support_widget.dart';

class PressingCheckoutScreen extends ConsumerStatefulWidget {
  final String orderId;

  PressingCheckoutScreen({super.key, required this.orderId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PressingCheckoutScreenState();
}

class PressingCheckoutScreenState
    extends ConsumerState<PressingCheckoutScreen> {
  PressingOrderModel? order;
  bool _initialized = false;
  late AdressFormService adressFormService;
  late LocalisationService localisationService;
  double? pickupDistanz;
  double? deliveyDistanz;
  Set<PressingServiceTypeModel> serviceTypes = {};
  Map<String, List<OrderItemModel>> orderItems = {};
  late PricingConfigModel pricingConfigModel;
  double? pickupFee;
  double? deliveryFee;

  @override
  void initState() {
    adressFormService = getIt<AdressFormService>();
    localisationService = getIt<LocalisationService>();
    pricingConfigModel = PricingConfigModel.fromRemote();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(appbarTitleProviderState)
          .setTitle(AppLocalizations.of(context)!.payment_title);
    });
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      await initOrder();
      await initDistanz();
      await initServicesType();
      await initServices();
    }
  }

  Future<void> initServices() async {
    final Map<String, List<OrderItemModel>> tempOrderItems = {};
    for (final type in serviceTypes) {
      final orderItems =
          order?.items
              .where((item) => item.service.serviceType == type)
              //   .map((item) => item)
              .toList();
      tempOrderItems[type.name] = orderItems ?? [];
    }
    setState(() {
      orderItems = tempOrderItems;
    });
  }

  Future<void> initServicesType() async {
    serviceTypes = order?.items.map((e) => e.service.serviceType).toSet() ?? {};
  }

  Future<void> initDistanz() async {
    if (order == null) return;
    final p_lat1 = order?.pickupAdress?.geoCordinates?.latitude ?? 0;
    final p_lon1 = order?.pickupAdress?.geoCordinates?.longitude ?? 0;
    final s_lat2 = order?.store.address.geoCordinates?.latitude ?? 0;
    final s_lon2 = order?.store.address.geoCordinates?.longitude ?? 0;
    pickupDistanz = localisationService.calculateDistance(
      p_lat1,
      p_lon1,
      s_lat2,
      s_lon2,
    );
    pickupFee = pickupDistanz! * pricingConfigModel.pricePerKm;
    final d_lat1 = order?.deliveryAdress?.geoCordinates?.latitude ?? 0;
    final d_lon1 = order?.deliveryAdress?.geoCordinates?.longitude ?? 0;
    deliveyDistanz = localisationService.calculateDistance(
      d_lat1,
      d_lon1,
      s_lat2,
      s_lon2,
    );
    deliveryFee = deliveyDistanz! * pricingConfigModel.pricePerKm;
    setState(() {});
  }

  Future<void> initOrder() async {
    final orders = ref.read(shoppingProviderState).orders;
    order = orders
        .where((e) => e.id == widget.orderId)
        .cast<PressingOrderModel?>()
        .firstWhere((e) => e != null, orElse: () => null);

    if (order == null) return;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          order != null
              ? SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    SupportWidget(title: order?.store.name),
                    const SizedBox(height: 3),
                    OrderInfo(order: order),

                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child:
                              order?.pickupDate != null
                                  ? CheckoutAdressWidget(
                                    title:
                                        AppLocalizations.of(
                                          context,
                                        )!.address_pickup ??
                                        '',
                                    address: order?.pickupAdress,
                                    date:
                                        order?.pickupDate != null
                                            ? DateFormat(
                                              'dd MMM yyyy',
                                              'fr',
                                            ).format(order!.pickupDate!)
                                            : 'No Date',
                                    adressTypeName: adressFormService
                                        .getAdressType(
                                          order?.pickupAdress?.adressType ?? '',
                                          context,
                                        ),
                                    distanz: pickupDistanz,
                                  )
                                  : SizedBox(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.pickup_pressing,
                                    ),
                                  ),
                        ),
                        Expanded(
                          child:
                              order?.deliveryDate != null
                                  ? CheckoutAdressWidget(
                                    title:
                                        AppLocalizations.of(
                                          context,
                                        )!.address_delivery ??
                                        '',
                                    address: order?.deliveryAdress,
                                    date:
                                        order?.deliveryDate != null
                                            ? DateFormat(
                                              'dd MMM yyyy',
                                              'fr',
                                            ).format(order!.pickupDate!)
                                            : 'No Date',

                                    adressTypeName: adressFormService
                                        .getAdressType(
                                          order?.deliveryAdress?.adressType ??
                                              '',
                                          context,
                                        ),
                                    distanz: deliveyDistanz,
                                  )
                                  : SizedBox(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.delivery_pressing,
                                    ),
                                  ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    CheckoutOrderItemsWidget(
                      itemsByService: orderItems,
                      totalAmount: order?.total ?? 0,
                    ),

                    const SizedBox(height: 3),

                    CheckoutTransportWidget(
                      servicesAmount: order?.total ?? 0 ,
                      pickupFee: pickupFee ?? 0,
                      deliveryFee: deliveryFee ?? 0
                    ),

                    BtnRegisterCancelWidget(
                      actionFCT: (BuildContext context, ButtonItem item) async {
                        context.push(item.routeName!);
                      },
                      actionRouteName:
                          '${RouteConstants.CHECKOUT_ROUTE}/:orderId',
                      cancelFCT: (BuildContext context, ButtonItem item) async {
                        context.pop();
                      },
                      actionTitle:
                          AppLocalizations.of(context)!.btn_payment_title,
                      icon: Icons.payment,
                    ),
                  ],
                ),
              )
              : Text('we have problem'),
    );
  }
}

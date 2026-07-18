import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/pressing/pressing_order_model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/services/form_services/adress_form_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/address/add_adress_widget.dart';
import 'package:movegui/widgets/address/display_adresses_widget.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/order/pressing/order_pressing_service_list_widget.dart';
import 'package:movegui/widgets/order/pressing/pick_and_delivery_widget.dart';
import 'package:movegui/widgets/price_total_widget.dart';
import 'package:movegui/widgets/util/btn_register_cancel_widget.dart';
import 'package:movegui/widgets/util/display_widget_title.dart';
import 'package:movegui/widgets/formsControllers/pressing_order_form_controller.dart';
import 'package:movegui/widgets/support/support_widget.dart';

class PressingOrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;
  final Color? backgroundColor;
  final Color? textColor;

  PressingOrderDetailsScreen({
    super.key,
    required this.orderId,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.textColor,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PressingOrderDetailsScreenState();
}

class PressingOrderDetailsScreenState
    extends ConsumerState<PressingOrderDetailsScreen> {
  PressingOrderModel? order;
  bool _initialized = false;
  Set<PressingServiceTypeModel> serviceTypes = {};
  List<PressingServiceModel> services = [];
  late PressingOrderFormController orderForm;
  late AdressFormService adressFormService;
  bool adressesHasChanged = false;
  final addAddressKey = GlobalKey<AddAdressWidgetState>();
  late UserService userService;

  @override
  void initState() {
    adressFormService = getIt<AdressFormService>();
    userService = getIt<UserService>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(appbarTitleProviderState)
          .setTitle(AppLocalizations.of(context)!.pressing_order_title);
    });
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      await initOrder();
    }
  }

  Future<void> initOrder() async {
    final orders = ref.read(shoppingProviderState).orders;

    order = orders
        .where((e) => e.id == widget.orderId)
        .cast<PressingOrderModel?>()
        .firstWhere((e) => e != null, orElse: () => null);

    if (order == null) return;
    orderForm = PressingOrderFormController(order: order!);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onSelectPickupDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && order != null) {
      setState(() {
        order!.pickupDate = picked;
      });
    }
  }

  Future<void> onSelectDeliveryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 5)),
    );

    if (picked != null && order != null) {
      setState(() {
        order!.deliveryDate = picked;
      });
    }
  }

  Future<void> onSelectPickupAdress() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.account_adresse),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: DisplayAdressesWidget(
                key: addAddressKey,
                registedAdressesCount:
                    order?.user.personModel?.addresses?.length ?? 0,
                user: order!.user,
                enabledAsStandard: true,
                adresses: order?.user.personModel?.addresses ?? [],
                onEdit: (int index) {
                  print('to Edit');
                },
                onRemove: (int index) {
                  print('to remove');
                },
                onDefaultChange: (int index) {
                  print('default change');
                },
              ),
            ),
          ),

          actions: [
            BtnRegisterCancelWidget(
              registerFCT: _registerAdressesFct,
              cancelFCT: _cancelFct,
            ),
          ],
        );
      },
    );
  }

  Future<void> _registerAdressesFct(
    BuildContext context,
    ButtonItem item,
  ) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      if (adressesHasChanged) {
        final newAdresses = await addAddressKey.currentState?.getAddresses();
        if (newAdresses != null && newAdresses.isNotEmpty) {
          final adresses = order?.user.personModel?.addresses ?? [];
          if (adresses.isNotEmpty) {
            order?.user.personModel?.addresses = newAdresses;
            await userService.update(order!.user);
            _cancelFct(context, item);
          }
        }
      }
    }
  }

  Future<void> _cancelFct(BuildContext context, ButtonItem item) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> onSelectDeliveryAdress() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.address_home_title),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: DisplayAdressesWidget(
                key: addAddressKey,
                registedAdressesCount:
                    order?.user.personModel?.addresses?.length ?? 0,
                user: order!.user,
                enabledAsStandard: true,
                adresses: order?.user.personModel?.addresses ?? [],
                onEdit: (int index) {
                  print('to Edit');
                },
                onRemove: (int index) {
                  print('to remove');
                },
                onDefaultChange: (int index) {
                  print('default change');
                },
              ),

              /*
               AddAdressWidget(
                key: addAddressKey,
                adresses: order?.user.personModel?.addresses ?? [],
                registedAdressesCount:
                    order?.user.personModel?.addresses?.length ?? 0,
                onCountChange: (bool value) {
                  setState(() {
                    adressesHasChanged = value;
                  });
                },
                user: order!.user,
                enabledAsStandard: true,
              ),
              */
            ),
          ),

          actions: [
            BtnRegisterCancelWidget(
              registerFCT: _registerAdressesFct,
              cancelFCT: _cancelFct,
            ),
          ],
        );
      },
    );
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
                    /// ✅ STATUS
                    //   _buildStatus(),
                    const SizedBox(height: 3),
                    SupportWidget(),

                    const SizedBox(height: 3),

                    //      _buildOrderInfo(),
                    PickAndDeliveryWidget(
                      pickupLocation:
                          order?.user.personModel?.addresses?.first?.address ??
                          '',
                      deliveryLocation:
                          order?.user.personModel?.addresses?.first?.address ??
                          '',
                      pickupDate: order?.pickupDate,
                      deliveryDate: order?.deliveryDate,
                      onSelectPickup: onSelectPickupAdress,
                      onSelectDelivery: onSelectDeliveryAdress,
                      onSelectPickupDate: onSelectPickupDate,
                      onSelectDeliveryDate: onSelectDeliveryDate,
                    ),

                    const SizedBox(height: 3),

                    OrderPressingServiceListWidget(
                      backgroundColor: AppColors.backgroundColor,
                      textColor: AppColors.textColor,
                      order: order!,
                      addQuantities: (int index) {
                        setState(() {
                          order!.items[index].qty += 1;
                          order!.total +=
                              order!.items[index].service.basePrice!;
                        });
                      },
                      reduceQuantities: (int index) {
                        setState(() {
                          order!.items[index].qty -= 1;
                          order!.total -=
                              order!.items[index].service.basePrice!;
                        });
                      },
                      removeService: (int index) {},
                      //      services: services,
                      //      servicesType: serviceTypes.toList(),
                    ),

                    const SizedBox(height: 16),

                    /// ✅ PRICE SUMMARY
                    _buildSummary(),

                    const SizedBox(height: 24),

                    /// ✅ ACTION BUTTONS
                    _buildActions(context),
                  ],
                ),
              )
              : Text('we have problem'),
    );
  }

  Widget _buildStatus() {
    Color color = Colors.black;
    if (order != null) {
      switch (order!.status) {
        case "pending":
          color = Colors.orange;
          break;
        case "in_progress":
          color = Colors.blue;
          break;
        case "delivered":
          color = Colors.green;
          break;
        case "Ordered":
          color = Colors.deepOrange;
        default:
          color = Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        order!.status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// =============================
  ///

  Widget _buildOrderInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Commande ${order!.id}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  order!.status,
                  style: TextStyle(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerCard() {
    final person = order?.user.personModel;

    final phone = person?.phone ?? 'No phone';
    final address =
        (person?.addresses != null && person!.addresses!.length >= 0)
            ? person.addresses?.first?.address ?? 'No address'
            : 'No address';

    return Card(
      color: widget.backgroundColor,
      child: ListTile(
        //   leading: const Icon(Icons.person),
        title: DisplayWidgetTitle(
          text: AppLocalizations.of(context)!.user_info,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(phone), Text(address)],
        ),
      ),
    );
  }

  /// =============================

  Widget _buildItemsList() {
    return Card(
      color: widget.backgroundColor,
      child: Column(
        children: [
          _buildServicesHeader(),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order!.items.length,
            itemBuilder: (context, index) {
              final item = order!.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(color: widget.textColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item.service.serviceType.name,
                        style: TextStyle(color: widget.textColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.service.product.name,
                        style: TextStyle(color: widget.textColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.qty.toString(),
                        style: TextStyle(color: widget.textColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${item.total.toString()} ${item.service.product.currency}',
                        style: TextStyle(color: widget.textColor),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const Divider(thickness: 0.5),

                    // _buildTotal(),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          PriceTotalWidget(
            total: order!.total,
            currency: order!.currency,
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ],
      ),

      /*
      Column(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.pressing_service_title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),

          ...order!.items.map((item) {
            final totalItem = item.qty * item.service.basePrice!;

            return ListTile(
              title: Text(item.name),
              subtitle: Text("Qty: ${item.qty}"),
              trailing: Text("${totalItem.toStringAsFixed(2)} €"),
            );
          }),
        ],
      ),
      */
    );
  }

  Widget _buildServicesHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DisplayWidgetTitle(
              text: 'N°',
              textAlign: TextAlign.start,
              textColor: widget.textColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),

          Expanded(
            flex: 3,
            child: DisplayWidgetTitle(
              text: AppLocalizations.of(context)!.pressing_service_title,
              textAlign: TextAlign.start,
              textColor: widget.textColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: DisplayWidgetTitle(
              text:
                  AppLocalizations.of(context)!.pressing_service_article_title,
              textAlign: TextAlign.start,
              textColor: widget.textColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: DisplayWidgetTitle(
              text: AppLocalizations.of(context)!.pressing_service_article_qty,
              textColor: widget.textColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: DisplayWidgetTitle(
              text:
                  AppLocalizations.of(context)!.pressing_service_article_price,
              textAlign: TextAlign.end,
              textColor: widget.textColor,
              backgroundColor: widget.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  /// =============================

  Widget _buildSummary() {
    final itemsTotal = order!.items.fold(
      0.0,
      (sum, item) => sum + (item.qty * item.service.basePrice!),
    );

    return Card(
      child: Column(
        children: [
          _row("Items total", itemsTotal),
          //    _row("Delivery", order.deliveryFee),
          const Divider(),
          _row("TOTAL", order!.total, isBold: true),
        ],
      ),
    );
  }

  Widget _row(String title, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "${value.toStringAsFixed(2)} €",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// =============================

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // TODO: mark as delivered
            },
            child: const Text("Mark Delivered"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // TODO: call customer
            },
            child: const Text("Call"),
          ),
        ),
      ],
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/pressing/pressing_order_model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/services/adress_service.dart';
import 'package:movegui/services/form_services/adress_form_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/address/display_adresses_widget.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/order/order_info.dart';
import 'package:movegui/widgets/order/pressing/order_pressing_service_list_widget.dart';
import 'package:movegui/widgets/order/pressing/pick_and_delivery_widget.dart';
import 'package:movegui/widgets/util/btn_register_cancel_widget.dart';
import 'package:movegui/widgets/formsControllers/pressing_order_form_controller.dart';
import 'package:movegui/widgets/support/support_widget.dart';

class PressingOrderDetailsScreen extends ConsumerStatefulWidget {
  final String orderId;

  PressingOrderDetailsScreen({super.key, required this.orderId});
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
  bool storeAdressesHasChanged = false;
  bool currentPositionHasChanged = false;
  final pickupAddressKey = GlobalKey<DisplayAdressesWidgetState>();
  final deliveryAddressKey = GlobalKey<DisplayAdressesWidgetState>();
  late UserService userService;
  String? _pickupId = null;
  String? _deliveryId = null;
  late AdressService adressService;
  AdressModel? currentAddress = null;

  @override
  void initState() {
    adressFormService = getIt<AdressFormService>();
    userService = getIt<UserService>();
    adressService = getIt<AdressService>();
    currentAddress = ref.read(addressProviderState).address;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(appbarTitleProviderState)
          .setTitle(AppLocalizations.of(context)!.pressing_order_title);
      if (currentAddress == null) {
        currentAddress = await adressService.getCurrentAddress(null);
        if (currentAddress != null)
          ref.read(addressProviderState).setAdress(currentAddress!);
      }

      print('current adress is: ${currentAddress?.toJson().toString()}');
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

  Future<void> setDefaultAdress() async {
    final addresses = order?.user.personModel?.addresses ?? [];
    for (final adress in addresses) {
      if (adress!.isDefault) {
        setState(() {
          order?.pickupAdress = adress;
          order?.deliveryAdress = adress;
        });
        return;
      }
    }
    if (!addresses.isEmpty) {
      setState(() {
        order?.pickupAdress = addresses[0];
        order?.deliveryAdress = addresses[0];
      });
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
    await setDefaultAdress();
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
    final addresses = order?.user.personModel?.addresses ?? [];
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.account_adresse),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: DisplayAdressesWidget(
                key: pickupAddressKey,
                addresses: addresses,
                onChange: (bool? value, String? selectedId) {
                  adressesHasChanged = value!;
                  _pickupId = selectedId;
                },
                storeAddress:
                    order?.store.address ?? AdressModel.getDaulftObject(),
                storeSelectionTitle:
                    AppLocalizations.of(context)!.pickup_pressing,
                onStoreSelection: (bool? value, String? selectedId) {
                  storeAdressesHasChanged = value!;
                  _pickupId = selectedId;
                },
                storeName: order?.store.name ?? 'Store',
                onCurrentPositionSelection: (bool? value, String? selectedId) {
                  currentPositionHasChanged = value!;
                  _pickupId = selectedId;
                },
                currentAddress: currentAddress,
              ),
            ),
          ),
          actions: [
            BtnRegisterCancelWidget(
              actionFCT: (dialogContext, item) async {
                _registerAdressesFct(dialogContext, item, pickupAddressKey);
              },
              cancelFCT: (dialogContext, item) async {
                _cancelFct(dialogContext, item, pickupAddressKey);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _registerAdressesFct(
    BuildContext dialogcontext,
    ButtonItem item,
    GlobalKey<DisplayAdressesWidgetState> addAddressKey,
  ) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        dialogcontext,
        AppLocalizations.of(dialogcontext)!.deactivate_button_title,
        AppLocalizations.of(dialogcontext)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else {
      if (adressesHasChanged) {
        final addresses =
            await addAddressKey.currentState?.getAddresses() ?? [];
        setState(() {
          order?.user.personModel?.addresses = addresses;
          for (final adr in addresses) {
            if (adr!.isDefault && adr.id == _pickupId) {
              order?.pickupAdress = adr;
              return;
            }
          }
          for (final adr in addresses) {
            if (adr!.isDefault && adr.id == _deliveryId) {
              order?.deliveryAdress = adr;
              return;
            }
          }
        });
        await userService.update(order!.user);
        ref.read(userProviderState).setUser(order!.user);
      }

      if (storeAdressesHasChanged) {
        setState(() {
          if (order?.store.address.id == _pickupId) {
            order?.pickupAdress = order?.store.address;
            order?.pickupOnStore = true;
          }
          if (order?.store.address.id == _deliveryId) {
            order?.deliveryAdress = order?.store.address;
            order?.deliveryOnStore = true;
          }
        });
      }

      if (currentPositionHasChanged) {
        setState(() {
          if (currentAddress?.id == _pickupId) {
            order?.pickupAdress = currentAddress;
          }
          if (currentAddress?.id == _deliveryId) {
            order?.deliveryAdress = currentAddress;
          }
        });
      }
      currentPositionHasChanged = false;
      storeAdressesHasChanged = false;
      adressesHasChanged = false;
      _cancelFct(dialogcontext, item, addAddressKey);
    }
  }

  Future<void> _cancelFct(
    BuildContext dialogcontext,
    ButtonItem item,
    GlobalKey<DisplayAdressesWidgetState> addAddressKey,
  ) async {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        dialogcontext,
        AppLocalizations.of(dialogcontext)!.deactivate_button_title,
        AppLocalizations.of(dialogcontext)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
      return;
    }

    if (adressesHasChanged) {
      await MessageWidget.showConfirmationDialog(
        dialogcontext,
        () async {
          await _registerAdressesFct(dialogcontext, item, addAddressKey);
        },
        () {
          adressesHasChanged = false;
          Navigator.pop(dialogcontext);
        },
      );
      return;
    }
    Navigator.pop(dialogcontext);
  }

  Future<void> onSelectDeliveryAdress() async {
    final addreses = order?.user.personModel?.addresses ?? [];
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.address_home_title),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: DisplayAdressesWidget(
                key: deliveryAddressKey,
                addresses: addreses,
                onChange: (bool? value, String? selectedId) {
                  adressesHasChanged = value!;
                  _deliveryId = selectedId;
                },
                storeAddress:
                    order?.store.address ?? AdressModel.getDaulftObject(),
                storeSelectionTitle:
                    AppLocalizations.of(context)!.delivery_pressing,
                onStoreSelection: (bool? value, String? selectedId) {
                  storeAdressesHasChanged = value!;
                  _deliveryId = selectedId;
                },
                storeName: order?.store.name ?? 'Store',
                onCurrentPositionSelection: (bool? value, String? selectedId) {
                  currentPositionHasChanged = value!;
                  _deliveryId = selectedId;
                },
                currentAddress: currentAddress,
              ),
            ),
          ),

          actions: [
            BtnRegisterCancelWidget(
              actionFCT: (dialogContext, item) async {
                _registerAdressesFct(dialogContext, item, deliveryAddressKey);
              },
              cancelFCT: (dialogContext, item) async {
                _cancelFct(dialogContext, item, deliveryAddressKey);
              },
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
                    const SizedBox(height: 3),
                    SupportWidget(title: order?.store.name),
                    const SizedBox(height: 3),
                    OrderInfo(order: order),
                    const SizedBox(height: 3),
                    PickAndDeliveryWidget(
                      pickupLocation:
                          order?.pickupAdress ?? AdressModel.getDaulftObject(),
                      deliveryLocation:
                          order?.deliveryAdress ??
                          AdressModel.getDaulftObject(),
                      pickupDate: order?.pickupDate,
                      deliveryDate: order?.deliveryDate,
                      onSelectPickup: onSelectPickupAdress,
                      onSelectDelivery: onSelectDeliveryAdress,
                      onSelectPickupDate: onSelectPickupDate,
                      onSelectDeliveryDate: onSelectDeliveryDate,
                    ),

                    const SizedBox(height: 3),

                    OrderPressingServiceListWidget(
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
                    ),
                    SizedBox(height: 3),
                    BtnRegisterCancelWidget(
                      actionFCT: (BuildContext context, ButtonItem item) async {
                        context.push(item.routeName!);
                      },
                      actionRouteName:
                          '${RouteConstants.CHECKOUT_ROUTE}/${widget.orderId}',
                      cancelFCT: (BuildContext context, ButtonItem item) async {
                        context.pop();
                      },
                      actionTitle:
                          AppLocalizations.of(context)!.btn_checkout_title,
                      icon: Icons.payment,
                    ),
                  ],
                ),
              )
              : Text('we have problem'),
    );
  }
}

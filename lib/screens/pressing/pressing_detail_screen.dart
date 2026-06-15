import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/providers/providers.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/auth/validation_button.dart';
import 'package:movegui/widgets/custom_text_field.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/pressing/pressing_price_list.dart';
import 'package:movegui/widgets/pressing/pressing_service_type_picker.dart';
import 'package:movegui/widgets/util/image_banner.dart';

class PressingDetailScreen extends ConsumerStatefulWidget {
  final String pressingId;

  const PressingDetailScreen({super.key, required this.pressingId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PressingDetailScreenState();
}

class PressingDetailScreenState extends ConsumerState<PressingDetailScreen> {
  late PressingService pressingService;
  final pressingConstants = PressingConstants();
  PressingModel? model;
  List<PressingServiceTypeModel> serviceTypes = [];
  List<PressingServiceModel> services = [];
  PressingServiceTypeModel? serviceType;
  bool _initialized = false;
  List<int> selectedQtys = [];
  List<PressingServiceModel> selectedServices = [];

  @override
  void initState() {
    pressingService = getIt<PressingService>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      initModel();
    }
  }

  Future<void> createOrder(BuildContext context, ButtonItem item) async {}

  Future<void> callMovegui(BuildContext context, ButtonItem item) async {}

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
        print('jojojojoj');
        serviceType = services[0].serviceType;
      }

      for (PressingServiceModel serviceModel in services) {
        serviceTypes.add(serviceModel.serviceType);
      }
      setState(() {});
    }
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
                      onServiceTypeChanged: (PressingServiceTypeModel? value) {
                        serviceType = value;
                      },
                      model: model!,
                      serviceTypes: serviceTypes,
                    ),
                  SizedBox(height: 6),
                  if (serviceType != null)
                    PressingPriceList(
                      allServices: services,
                      serviceType: serviceType!,
                      onServicesChanged: (services, qtys) async {
                        if (mounted) {
                          setState(() {
                            selectedServices = services;
                            selectedQtys = qtys;
                            print(totalQte(selectedQtys));
                          });
                        }
                      },
                    ),
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

                  Row(
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
                            totalQte(selectedQtys) > 0 ? true : false,
                            routeName: '',
                          ),
                          padding: 12,
                          fontSize: 14,
                          icon: Icons.shopping_cart,
                        ),
                      ),
                      SizedBox(width: 12),
                      /*
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                          backgroundColor: AppColors.backgroundColor,
                          // backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        icon: const Icon(
                          IconlyLight.send,
                          color: AppColors.textColor,
                        ),
                        label: const Text(
                          "Valider",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                      */

                      /*
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                          backgroundColor: AppColors.backgroundColor,
                          // backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        icon: const Icon(
                          IconlyLight.call,
                          color: AppColors.textColor,
                        ),
                        label: const Text(
                          "Appeler",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {},
                      ),
                      */
                      Expanded(
                        child: ValidationButton(
                          fn: (context, item) async {
                            await callMovegui(context, item);
                          },
                          buttonItem: ButtonItem(
                            AppLocalizations.of(context)!.btn_call_label,
                            AppLocalizations.of(context)!.tooltip_btn_call,
                            true,
                            routeName: '',
                          ),
                          padding: 12,
                          fontSize: 14,
                          icon: Icons.call,
                        ),
                      ),
                    ],
                  ),

                  /*
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.model.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  */
                  const SizedBox(height: 15),

                  /*
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: pressings.length,
                    crossAxisCount: 1,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context, index) {
                      return StoreWidget(model: pressings[index], catgory: AppConstants.CATEGORY_PRESSING,);
                    },
                  ),
                ),
                */
                ],
              ),
            ),
          ),
          /*
        bottomNavigationBar:RootBottomNavigationBar(
        currentIndex: 1,
        onDestinationSelected: (index) {
          Navigator.pop(context, index);
        },
      ),
      */
        ),
      ),
    );
  }
}

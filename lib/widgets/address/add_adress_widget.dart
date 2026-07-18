import 'package:flutter/material.dart';
import 'package:movegui/config/env_dev.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/form_services/adress_form_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/seed_service.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/address/address_widget.dart';
import 'package:movegui/widgets/app/separator_widget.dart';
import 'package:movegui/widgets/formsControllers/address_form_controller.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class AddAdressWidget extends StatefulWidget {
  final int registedAdressesCount;
  final ValueChanged<bool> onCountChange;
  final UserModel user;
  final bool enabledAsStandard;
  final List<AdressModel?>? adresses;
  final void Function(String, int) onAdressTypeChange;
  final void Function(String, int) onCommuneChange;
  final void Function(String) onChange;

  const AddAdressWidget({
    super.key,
    required this.registedAdressesCount,
    required this.onCountChange,
    required this.user,
    required this.enabledAsStandard,
    required this.adresses,
    required this.onAdressTypeChange,
    required this.onCommuneChange,
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() => AddAdressWidgetState();
}

class AddAdressWidgetState extends State<AddAdressWidget> {
  late SeedService seedService;
  bool enabled = false;
  bool isValid = false;
  late UserService userService;
  String _defaultAddressId = '';
  String adressId = '';
  late AdressFormService adressFormService;
  List<AddressFormController> formControllers = [];

  @override
  void initState() {
    super.initState();
    seedService = getIt<SeedService>();
    userService = getIt<UserService>();
    adressFormService = getIt<AdressFormService>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      formControllers = await adressFormService.getFormControllers(
        widget.adresses ?? [],
      );
      setDefaultId();
      setState(() {});
    });
  }

  Future<List<AdressModel?>?> getAddresses() async {
    return await adressFormService.getModels(formControllers);
  }

  void setDefaultId() {
    for (final address in widget.adresses!) {
      if (address!.isDefault) {
        _defaultAddressId = address.id;
        return;
      }
    }
    if (!widget.adresses!.isEmpty) {
      _defaultAddressId = widget.adresses?[0]?.id ?? '';
      widget.adresses?[0]?.isDefault = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clear(int index) {
    formControllers[index].clear();
    setState(() {
      formControllers[index].selectedMunicipality = '';
      formControllers[index].selectedType = '';
    });
  }

  Future<void> _addAdress() async {
    AdressModel? adressTestData;

    if (seedService.api.env is EnvDev) {
      adressTestData = await seedService.getgeneratedAdress();
    }

    setState(() {
      formControllers.add(AddressFormController());
      widget.onCountChange.call(true);
      if (adressTestData != null) {
        formControllers.last.setData(adressTestData);
      }
    });
  }

  void remove(int index) {
    if (formControllers.length == 1) return;

    setState(() {
      final removedController = formControllers.removeAt(index);
      widget.onCountChange.call(true);
      removedController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (formControllers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: formControllers.length,
          itemBuilder: (context, index) {
            adressId = formControllers[index].id ?? '';
            return Center(
              child: Container(
                width:
                    Responsive.isDesktop(context)
                        ? size.width * 0.5
                        : double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  //    color: AppColors.backgroundColor,
                ),
                child: Column(
                  children: [
                    AddressWidget(
                      onCommuneChange: (value) {
                        formControllers[index].selectedMunicipality = value!;
                        widget.onCommuneChange.call(value, index);
                      },
                      onAdressTypeChange: (type) {
                        formControllers[index].selectedType = type!;
                        widget.onAdressTypeChange.call(type, index);
                      },
                      addressForm: formControllers[index],
                      onChange: (String value) {
                        setState(() {
                          isValid = formControllers[index].isValid();
                          widget.onChange.call(value);
                        });
                      },
                    //  readOnly: readOnlyAdresses[index],
                      defaultId: _defaultAddressId,
                      onDefaultAdressChange: () {
                        setState(() {
                          _defaultAddressId = adressId;
                        });
                      },
                      onUpdateAdresse: () {
                        setState(() {
                               widget.onChange.call('');
                        });
                       
                      },
                      onRemoveAdress: () {
                        remove(index);
                      },
                    ),
                    SeparatorWidget(height: WidgetConstants.sepWidget),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: WidgetConstants.sepWidget);
          },
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:
                  widget.registedAdressesCount > 0
                      ? ButtonWidget(
                        onPressed: (context, item) async {
                          _addAdress();
                        },
                        buttonItem: ButtonItem(
                          title: AppLocalizations.of(context)!.btn_add_adress,
                          tooltipText:
                              AppLocalizations.of(
                                context,
                              )!.tooltip_btn_add_adress,
                          enabled: true,
                          routeName: '',
                        ),
                        icon: Icons.add,
                        //   backgroundColor: AppColors.darkPrimary,
                      )
                      : SizedBox(),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/seed_service.dart';
import 'package:movegui/services/user_service.dart';
import 'package:movegui/widgets/address/display_adress_widget.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class DisplayAdressesWidget extends StatefulWidget {
  final int registedAdressesCount;
  final void Function(int) onEdit;
  final void Function(int) onRemove;
   final void Function(int) onDefaultChange;
  final UserModel user;
  final bool enabledAsStandard;
  final List<AdressModel?>? adresses;

  const DisplayAdressesWidget({
    super.key,
    required this.registedAdressesCount,
    required this.onEdit,
    required this.onRemove,
    required this.user,
    required this.enabledAsStandard,
    required this.adresses,
    required this.onDefaultChange
  });

  @override
  State<StatefulWidget> createState() => DisplayAdressesWidgetState();
}

class DisplayAdressesWidgetState extends State<DisplayAdressesWidget> {
  late SeedService seedService;
  bool enabled = false;
  bool isValid = false;
  late UserService userService;
  String _defaultAddressId = '';
  String adressId = '';

  @override
  void initState() {
    super.initState();
    seedService = getIt<SeedService>();
    userService = getIt<UserService>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setDefaultId();
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (widget.adresses!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.adresses?.length ?? 0,
          itemBuilder: (context, index) {
            adressId = widget.adresses?[index]?.id ?? '';
            final adress = widget.adresses?[index];
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
                child: DisplayAdressWidget(
                  adress: adress,
                  onRemove: () {
                    widget.onRemove.call(index);
                  },
                  onEdit: () {
                    widget.onEdit.call(index);
                  },
                  onDefaultChange: () {
                    widget.onDefaultChange(index);
                  },
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
                          //  _addAdress();
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
                      )
                      : SizedBox(),
            ),
          ],
        ),
      ],
    );
  }
}

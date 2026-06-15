import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/models/pressing/pressing_model.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/register_services.dart';

class PressingServiceTypePicker extends ConsumerStatefulWidget {
  final PressingServiceTypeModel? serviceType;
  final ValueChanged<PressingServiceTypeModel?> onServiceTypeChanged;
  final List<PressingServiceTypeModel> serviceTypes;
  final PressingModel model;

  const PressingServiceTypePicker({
    super.key,
    required this.serviceType,
    required this.onServiceTypeChanged,
    required this.model,
    required this.serviceTypes,
  });

  @override
  ConsumerState<PressingServiceTypePicker> createState() =>
      _GenderAndBirthdatePickerState();
}

class _GenderAndBirthdatePickerState
    extends ConsumerState<PressingServiceTypePicker> {
  PressingServiceTypeModel? _selectedServiceType;
  late PressingService pressingService;
  List<PressingServiceTypeModel> pressingServices = [];

  @override
  void initState() {
    super.initState();
    pressingService = getIt<PressingService>();
    _selectedServiceType = widget.serviceType;
    pressingServices = widget.serviceTypes;
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    //  initServices();
  }

  Future<void> initServices() async {
    if (mounted) {
      setState(() {
        pressingServices = AppConstants.getPressingServices(context);
        if (pressingServices.isNotEmpty) {
          _selectedServiceType = pressingServices[0];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<PressingServiceTypeModel>(
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundColor,
                labelText: 'Services',
                labelStyle: TextStyle(
                  color: AppColors.textColor,
                  fontSize: WidgetConstants.subTitleFontSize,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: WidgetConstants.subTitleFontSize * 0.8,
              ),
              dropdownColor: AppColors.backgroundColor,
              iconEnabledColor: AppColors.textColor,
              value: _selectedServiceType,
              items:
                  pressingServices
                      .map(
                        (elem) => DropdownMenuItem(
                          value: elem,
                          child: Text(elem.name),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() => _selectedServiceType = value);
                widget.onServiceTypeChanged.call(value!);
              },
              validator: (value) {
                return MyValidators.textValidator(value!.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}

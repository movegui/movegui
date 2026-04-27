import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/validator.dart';
import 'package:movegui/consts/widget_constants.dart';


class GenderPicker extends StatefulWidget {
  final String? gender;
  final ValueChanged<String?> onGenderChanged;

  const GenderPicker({super.key, required this.gender, required this.onGenderChanged});

  @override
  State<GenderPicker> createState() => _GenderAndBirthdatePickerState();
}

class _GenderAndBirthdatePickerState extends State<GenderPicker> {
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundColor,
                labelText: 'Genre',
                labelStyle: TextStyle(color: AppColors.textColor , fontSize: WidgetConstants.subTitleFontSize),
                border: InputBorder.none,
              ),
             style: TextStyle(color: AppColors.textColor, fontSize: WidgetConstants.subTitleFontSize * 0.8),
              dropdownColor: AppColors.backgroundColor,
              iconEnabledColor: AppColors.textColor,
              value: _selectedGender,
              items: const [
                DropdownMenuItem(value: 'm', child: Text('Homme')),
                DropdownMenuItem(value: 'f', child: Text('Femme')),
                DropdownMenuItem(value: 'o', child: Text('Autre')),
              ],
              onChanged: (value) {
                setState(() => _selectedGender = value);
                widget.onGenderChanged.call(value!);
              },
              validator: (value) {
                return MyValidators.textValidator(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

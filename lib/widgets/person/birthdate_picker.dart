import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:movegui/widgets/error/message_widget.dart';

class BirthdatePicker extends StatefulWidget {
  final DateTime? birthDate;
  final ValueChanged<DateTime?>? onBirthDateChanged;

  const BirthdatePicker({super.key, this.birthDate, this.onBirthDateChanged});

  @override
  State<BirthdatePicker> createState() => _GenderAndBirthdatePickerState();
}

class _GenderAndBirthdatePickerState extends State<BirthdatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.birthDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate =
        _selectedDate ?? DateTime(now.year, now.month, now.day);
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = DateTime(now.year, now.month, now.day);
    ;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      final now = DateTime.now();
      final adultDate = DateTime(now.year - 18, now.month, now.day);

      if (picked.isBefore(adultDate) || picked.isAtSameMomentAs(adultDate)) {
        setState(() {
          _selectedDate = picked;
        });
        widget.onBirthDateChanged?.call(picked);
      } else {
        MessageWidget.errorMessage(
          context,
          'Erreur d\'age',
          'Vous devez être âgé d\'au moins 18 ans.',
          Icon(Icons.error, color: AppColors.error),
          FlushbarPosition.TOP,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        _selectedDate != null
            ? DateFormat('dd MMM yyyy').format(_selectedDate!)
            : 'Selectionner Date de Naissance';

    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 12),
            // Birthdate picker
            InkWell(
              onTap: () => _pickDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  labelText: 'Date de Naissance',
                  labelStyle: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 22,
                  ),
                  border: InputBorder.none,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedDate != null
                        ? Text(
                          formattedDate,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14,
                          ),
                        )
                        : Expanded(
                          child: Text(
                            'Selectionner ',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    const Icon(
                      Icons.calendar_today,
                      color: AppColors.textColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

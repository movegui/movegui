import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/adress_model.dart';

class DisplayAdressWidget extends StatefulWidget {
  const DisplayAdressWidget({
    super.key,
    required this.onEdit,
    required this.onRemove,
    required this.adress,
    required this.onDefaultChange,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onRemove;
  final AdressModel? adress;
  final VoidCallback onDefaultChange;

  @override
  State<StatefulWidget> createState() => DisplayAdressWidgetState();
}

class DisplayAdressWidgetState extends State<DisplayAdressWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    widget.adress?.adressType == AddressType.HOME
                        ? Icons.home
                        : widget.adress?.adressType == AddressType.OFFICE
                        ? Icons.work
                        : Icons.location_on,
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    getAdressType(widget.adress?.adressType ?? ''),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.adress?.isDefault ?? false)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Par défaut',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.adress?.address ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.adress?.district ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                 const SizedBox(height: 4),
                 standardAdresseWidget(),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onEdit,
                    icon: const Icon(Icons.edit),
                    label:  Text(AppLocalizations.of(context)!.btn_update),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onRemove,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label:  Text(
                      AppLocalizations.of(context)!.btn_delete,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget standardAdresseWidget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context)!.standard_address,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Radio<bool>(
            value: true,
            groupValue: widget.adress?.isDefault ?? false,
            onChanged: (_) {
              widget.onDefaultChange();
            },
          ),
        ),
      ],
    );
  }

  String getAdressType(String value) {
    switch (value) {
      case 'h':
        return AppLocalizations.of(context)!.address_home_title;
      case 'o':
        return AppLocalizations.of(context)!.address_office_title;
      case 'n':
        return AppLocalizations.of(context)!.address_neighbor_title;
      case 'ot':
        return AppLocalizations.of(context)!.address_other_title;
      default:
        return 'No Type';
    }
  }
}

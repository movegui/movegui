import 'package:flutter/material.dart';
import 'package:movegui/l10n/app_localizations.dart';

class PickAndDeliveryWidget extends StatelessWidget {
  final String? pickupLocation;
  final String? deliveryLocation;
  final DateTime? pickupDate;
  final DateTime? deliveryDate;

  final VoidCallback onSelectPickup;
  final VoidCallback onSelectDelivery;
  final VoidCallback onSelectPickupDate;
  final VoidCallback onSelectDeliveryDate;

  const PickAndDeliveryWidget({
    super.key,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.pickupDate,
    required this.deliveryDate,
    required this.onSelectPickup,
    required this.onSelectDelivery,
    required this.onSelectPickupDate,
    required this.onSelectDeliveryDate,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget _buildField({
    required IconData icon,
    required Color color,
    required String label,
    required String placeholder,
    required String? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    placeholder,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value?.isNotEmpty == true ? value! : 'Non sélectionné',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color:
                          value?.isNotEmpty == true
                              ? Colors.black
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📦 ${AppLocalizations.of(context)?.detail_delivery_title ?? 'Delivery Details'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildField(
              icon: Icons.location_on,
              color: Colors.red,
              label: "pickup",
              placeholder:
                  " ${AppLocalizations.of(context)?.detail_delivery_pickup ?? 'Select Pickup Location'}",
              value: pickupLocation,
              onTap: onSelectPickup,
            ),

            const SizedBox(height: 12),

            // PICKUP DATE
            _buildField(
              icon: Icons.calendar_today,
              color: Colors.orange,
              label: "pickup_date",
              placeholder:
                  " ${AppLocalizations.of(context)?.detail_delivery_pickup_date ?? 'Select Pickup Date'}",
              value: _formatDate(pickupDate),
              onTap: onSelectPickupDate,
            ),

            const SizedBox(height: 12),

            // DELIVERY LOCATION
            _buildField(
              icon: Icons.local_shipping,
              color: Colors.blue,
              label: "delivery",
              placeholder:
                  " ${AppLocalizations.of(context)?.detail_delivery_delivery ?? 'Select Delivery Location'}",
              value: deliveryLocation,
              onTap: onSelectDelivery,
            ),

            const SizedBox(height: 12),

            // DELIVERY DATE
            _buildField(
              icon: Icons.event,
              color: Colors.green,
              label: "delivery_date",
              placeholder:
                  " ${AppLocalizations.of(context)?.detail_delivery_delivery_date ?? 'Select Delivery Date'}",
              value: _formatDate(deliveryDate),
              onTap: onSelectDeliveryDate,
            ),
          ],
        ),
      ),
    );
  }
}

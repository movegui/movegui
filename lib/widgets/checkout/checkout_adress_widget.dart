import 'package:flutter/material.dart';
import 'package:movegui/models/adress_model.dart';

class CheckoutAdressWidget extends StatelessWidget {
  final String title;
  final AdressModel? address;
  final String? date;
  final String timeRange;
  final String? adressTypeName;
  final double? distanz;

  const CheckoutAdressWidget({
    super.key,
    required this.title,
    required this.address,
    required this.date,
    this.timeRange = "8:00 - 15:00",
    required this.adressTypeName,
    required this.distanz
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:  [
                Icon(Icons.inventory_2_outlined),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),

            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    address?.adressType == AddressType.HOME
                        ? Icons.home
                        : address?.adressType == AddressType.OFFICE
                        ? Icons.work
                        : Icons.location_on,
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    adressTypeName ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address?.address ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address?.district ?? '',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const Divider(height: 4),

            Row(
              children: [
                const Icon(Icons.calendar_month, size: 18),
                const SizedBox(width: 8),
                Text(date ?? 'No date'),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 8),
                Text(timeRange),
              ],
            ),
            const Divider(height: 4),
             Row(
              children: [
                const Icon(Icons.my_location, size: 18),
                const SizedBox(width: 8),
                Text('${distanz?.toStringAsFixed(1)} km'),
              ],
            ),
          ],
        ),
      ),
    );
  }


}

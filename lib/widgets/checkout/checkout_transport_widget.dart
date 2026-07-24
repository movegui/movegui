import 'package:flutter/material.dart';

class CheckoutTransportWidget extends StatelessWidget {
  final double servicesAmount;
  final double pickupFee;
  final double deliveryFee;

  const CheckoutTransportWidget({
    super.key,
    required this.servicesAmount,
    required this.pickupFee,
    required this.deliveryFee,
  });

  double get total => servicesAmount + pickupFee + deliveryFee;

  String _formatPrice(double value) {
    return '${value.toStringAsFixed(0)} GNF';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row(
              icon: Icons.local_laundry_service,
              label: 'Services',
              value: _formatPrice(servicesAmount),
            ),

            const SizedBox(height: 8),

            _row(
              icon: Icons.inventory_2_outlined,
              label: 'Ramassage',
              value: pickupFee == 0
                  ? 'Gratuit'
                  : _formatPrice(pickupFee),
            ),

            const SizedBox(height: 8),

            _row(
              icon: Icons.local_shipping_outlined,
              label: 'Livraison',
              value: deliveryFee == 0
                  ? 'Gratuit'
                  : _formatPrice(deliveryFee),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),

            _row(
              icon: Icons.payments_outlined,
              label: 'Total à payer',
              value: _formatPrice(total),
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: isTotal ? 24 : 20,
          color: isTotal
              ? Colors.green
              : Colors.grey.shade700,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Colors.green : Colors.black87,
          ),
        ),
      ],
    );
  }
}

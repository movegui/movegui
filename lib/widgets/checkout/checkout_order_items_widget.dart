
import 'package:flutter/material.dart';
import 'package:movegui/models/order_item_model.dart';

class CheckoutOrderItemsWidget extends StatelessWidget {
  final Map<String, List<OrderItemModel>> itemsByService;
  final double totalAmount;

  const CheckoutOrderItemsWidget({
    super.key,
    required this.itemsByService,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.checkroom),
                SizedBox(width: 8),
                Text(
                  'Articles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ...itemsByService.entries.map(
              (serviceEntry) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceEntry.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ...serviceEntry.value.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${item.service.product.name} x ${item.qty}',
                            ),
                          ),
                          Text(
                            '${item.total.toStringAsFixed(0)} GNF',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),

            const Divider(),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '${totalAmount.toStringAsFixed(0)} GNF',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
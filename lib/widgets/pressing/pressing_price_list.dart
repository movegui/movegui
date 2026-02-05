
import 'package:flutter/material.dart';

class PressingPriceList extends StatelessWidget {
  const PressingPriceList({Key? key}) : super(key: key);

  final List<Map<String, String>> prices = const [
    {'service': 'Chemise', 'prix': '10 000 GNF'},
    {'service': 'Pantalon', 'prix': '15 000 GNF'},
    {'service': 'Robe', 'prix': '20 000 GNF'},
    {'service': 'Costume complet', 'prix': '40 000 GNF'},
    {'service': 'Couvre-lit', 'prix': '30 000 GNF'},
    {'service': 'Nettoyage à sec (kg)', 'prix': '25 000 GNF'},
  ];

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
            itemCount: prices.length,
            itemBuilder: (context, index) {
              final item = prices[index];
              return ListTile(
                leading: const Icon(Icons.local_laundry_service),
                title: Text(item['service']!),
                trailing: Text(item['prix']!),
              );
            },
        );


  }
}
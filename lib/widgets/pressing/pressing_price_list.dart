import 'package:flutter/material.dart';

import 'package:movegui/consts/app_colors.dart';

class PressingPriceList extends StatefulWidget {
  const PressingPriceList({Key? key}) : super(key: key);

  @override
  State<PressingPriceList> createState() => _PressingPriceListState();
}

class _PressingPriceListState extends State<PressingPriceList> {
  final List<Map<String, dynamic>> prices = [
    {'service': 'Chemise', 'prix': 10000, 'qty': 1},
    {'service': 'Pantalon', 'prix': 15000, 'qty': 1},
    {'service': 'Robe', 'prix': 20000, 'qty': 1},
    {'service': 'Costume complet', 'prix': 40000, 'qty': 1},
    {'service': 'Couvre-lit', 'prix': 30000, 'qty': 1},
  ];

  int get total {
    return prices.fold(
      0,
      (sum, item) => sum + (item['prix'] * item['qty']) as int,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),

        const Divider(),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prices.length,
          itemBuilder: (context, index) {
            final item = prices[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  // Service
                  Expanded(flex: 3, child: Text(item['service'])),

                  // Quantité
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color:  item['qty'] > 0 ? AppColors.backgroundColor : AppColors.disabled,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8),
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              size: 14,
                              color: AppColors.textColor,
                            ),
                            onPressed:
                                item['qty'] > 0
                                    ? () => setState(() => item['qty']--)
                                    : null,
                          ),
                        ),
                        /*
                        IconButton(
                          icon: const Icon(Icons.remove, size: 18, color: AppColors.backgroundColor,),
                          onPressed: item['qty'] > 1
                              ? () => setState(() => item['qty']--)
                              : null,
                        ),
                        */
                        SizedBox(width: 6,),
                        Text(item['qty'].toString()),
                        SizedBox(width: 6,),
                         Material(
                          color:  AppColors.backgroundColor,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(8),
                          child:      IconButton(
                          icon: const Icon(Icons.add, size: 14, color: AppColors.textColor,),
                          onPressed: () => setState(() => item['qty']++),
                        ),
                        ),
                        /*
                        IconButton(
                          icon: const Icon(Icons.add, size: 18),
                          onPressed: () => setState(() => item['qty']++),
                        ),
                        */
                      ],
                    ),
                  ),

                  // Prix
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${item['prix'] * item['qty']} GNF',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const Divider(thickness: 1.5),

        _buildTotal(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              'Service',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text('Qté', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Prix',
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotal() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Expanded(
            flex: 5,
            child: Text(
              'TOTAL',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '$total GNF',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



/*
class PressingPriceList extends StatelessWidget {
  const PressingPriceList({Key? key}) : super(key: key);

  final List<Map<String, String>> prices = const [
    {'service': 'Chemise', 'prix': '10 000 GNF'},
    {'service': 'Pantalon', 'prix': '15 000 GNF'},
    {'service': 'Robe', 'prix': '20 000 GNF'},
    {'service': 'Costume complet', 'prix': '40 000 GNF'},
    {'service': 'Couvre-lit', 'prix': '30 000 GNF'},
  //  {'service': 'Nettoyage à sec (kg)', 'prix': '25 000 GNF'},
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

*/
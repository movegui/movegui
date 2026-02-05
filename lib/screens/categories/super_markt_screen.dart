
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/super_markt_model.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/services/patisseries_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/super_markts_service.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/store/store_widget.dart';
import 'package:provider/provider.dart';

class SuperMarktScreen  extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => SuperMarktScreenState();
  
}

class SuperMarktScreenState extends State<SuperMarktScreen>{

   
 late TextEditingController searchTextController;
  List<SuperMarktModel> superMarkts = [];
  late SuperMarktsService superMarktsService;
  final superMarktConstants = SuperMarktConstants();
    


  @override
  void initState() {
    searchTextController = TextEditingController();
     superMarktsService = getIt<SuperMarktsService>();
      initList();
    super.initState();

  }

    Future<void> initList() async {
    final allSuperMarkts = await superMarktsService.allModels();
    setState(() {
      superMarkts = allSuperMarkts;
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
      final shoppingProvider = Provider.of<ShoppingProvider>(context);
  return Material(
    color: Colors.transparent, // or Colors.white
    child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MoveguiAppBar(title: superMarktConstants.getTitleName(), itemCount: shoppingProvider.itemCount),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
        
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                    },
                    child: const Icon(Icons.clear, color: Colors.red),
                  ),
                ),
              ),
        
              const SizedBox(height: 15),
        
              Expanded(
                child: DynamicHeightGridView(
                  itemCount: superMarkts.length,
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  builder: (context, index) {
                    return StoreWidget(model: superMarkts[index], catgory: AppConstants.CATEGORY_SUPERMARKT,);
                  },
                ),
              ),
            ],
          ),
        ),
        /*
        bottomNavigationBar:RootBottomNavigationBar(
        currentIndex: 1,
        onDestinationSelected: (index) {
          Navigator.pop(context, index);
        },
      ),
      */
      ),
    ),
  );
}

}
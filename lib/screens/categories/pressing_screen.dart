
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/pressing_model.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/app/appbar.dart';
import 'package:movegui/widgets/menu/menu.dart';
import 'package:movegui/widgets/store/store_widget.dart';
import 'package:provider/provider.dart';

class PressingScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => PressingScreenState();
  
}

class PressingScreenState extends State<PressingScreen>{
  
 late TextEditingController searchTextController;
  List<PressingModel> pressings = [];
  late PressingService pressingService;
  final pressingConstants = PressingConstants();
    


  @override
  void initState() {
    searchTextController = TextEditingController();
     pressingService = getIt<PressingService>();
      initList();
    super.initState();

  }

    Future<void> initList() async {
    final allPressings = await pressingService.allModels();
    setState(() {
      pressings = allPressings;
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
      //  appBar: MoveguiAppBar(title: pressingConstants.getTitleName(), itemCount: shoppingProvider.itemCount),
        drawer: MoveGuiMenu(),
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
                  itemCount: pressings.length,
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  builder: (context, index) {
                    return StoreWidget(model: pressings[index], catgory: AppConstants.CATEGORY_PRESSING,);
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
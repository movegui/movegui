
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:movegui/models/categories_model.dart';
import 'package:movegui/screens/main/command_screen.dart';
import 'package:movegui/screens/main/develivery_screen.dart';
import 'package:movegui/screens/main/home_screen.dart';
import 'package:movegui/screens/main/reservation_screen.dart';
import 'package:movegui/services/categories_service.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/widgets/category/categories_widget.dart';




class CategoriesScreen extends StatefulWidget{

  final int categoryType;
  CategoriesScreen({super.key, required this.categoryType});
  
  @override
  State<StatefulWidget> createState() => CategoriesScreenState();

 


}

class CategoriesScreenState extends State<CategoriesScreen>{

  late TextEditingController searchTextController;
  List<CategoriesModel> models = [];
  final CategoriesService service = getIt<CategoriesService>();

    
  late List<Widget> screens;
   int currentScreen = 0;
  late PageController controller;

  @override
  void initState() {
    searchTextController = TextEditingController();
    // restaurantsService = getIt<RestaurantsService>();
      initList();
    super.initState();
           screens = [
      HomeScreen(title: 'Home',),
      ReservationScreen(title: 'Reservation'),
      Commandscreen(title: 'Commande',),
      DeveliveryScreen(title: 'Livraison',)

    ];
    controller = PageController(initialPage: currentScreen);
  }

    Future<void> initList() async {
      late List<CategoriesModel> allModels ;
      switch(widget.categoryType){
        case 0: 
         allModels = await service.getAllCommandCategories();
         break;
        case 1: 
        allModels = await service.getCourseCategories();
         break;
      }
    
    setState(() {
      models = allModels;
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
  
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // setState(() {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                      // });
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  print("value of the text is $value");
                },
                onSubmitted: (value) {
                  // log("value of the text is $value");
                  // log("value of the controller text: ${searchTextController.text}");
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: DynamicHeightGridView(
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context, index) {
                      return CategoriesWidget(model: models[index],);
                    },
                    itemCount: models.length,
                    crossAxisCount: 1),
              ),
            ],
          ),
        ),
    );
  }

}
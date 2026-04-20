import 'package:flutter/material.dart';
import 'package:movegui/consts/app_constants.dart';
import 'package:movegui/models/restaurant_model.dart';
import 'package:movegui/providers/shopping_provider.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/register_services.dart';
import 'package:movegui/services/restaurants_service.dart';
import 'package:movegui/widgets/store/store_widget.dart';
import 'package:provider/provider.dart';

class RestoScreen extends StatefulWidget {
  const RestoScreen({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<RestoScreen> createState() => _RestoScreenState();
}

class _RestoScreenState extends State<RestoScreen> {
  late TextEditingController searchTextController;
  List<RestaurantModel> restaurants = [];
  late RestaurantsService restaurantsService;
  final restaurantConstants = RestaurantConstants();
  late int displayItem;

  @override
  void initState() {
    searchTextController = TextEditingController();
    restaurantsService = getIt<RestaurantsService>();
    initList();
    super.initState();
  }

  Future<void> initList() async {
    final allRestaurants = await restaurantsService.allModels();
    if (!mounted) return;
    setState(() {
      restaurants = allRestaurants;
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  getDistplayItemCount(BuildContext context) {
    if (Responsive.isDesktop(context)) return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final shoppingProvider = Provider.of<ShoppingProvider>(context);
    return Material(
      color: Colors.transparent, // or Colors.white
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Responsive.isDesktop(context) ? buildDesktop() : buildMobil()
          ),
        ),
      ),
    );
  }

  Widget buildMobil() {
    return Column(
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
            itemCount: restaurants.length,
            crossAxisCount: 1,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            builder: (context, index) {
              return StoreWidget(
                model: restaurants[index],
                catgory: AppConstants.CATEGORY_RESTAURANT,
              //  navigatorKey: widget.navigatorKey,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDesktop() {
    return Column(
      children: [
        Expanded(
          child: DynamicHeightGridView(
            itemCount: restaurants.length,
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            builder: (context, index) {
              return StoreWidget(
                model: restaurants[index],
                catgory: AppConstants.CATEGORY_RESTAURANT,
            //    navigatorKey: widget.navigatorKey,
              );
            },
          ),
        ),
      ],
    );
  }
}




import 'package:get_it/get_it.dart';
import 'package:movegui/services/categories_service.dart';
import 'package:movegui/services/ingredients_service.dart';
import 'package:movegui/services/patisseries_service.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/professionnel_service.dart';
import 'package:movegui/services/restaurant_type_service.dart';
import 'package:movegui/services/restaurants_service.dart';
import 'package:movegui/services/super_markts_service.dart';
import 'package:movegui/services/suppliers_service.dart';

final getIt = GetIt.instance;

void initServices(){
  getIt.registerLazySingleton<CategoriesService>(() => CategoriesService());
  getIt.registerLazySingleton<SuppliersService>(() => SuppliersService());
  getIt.registerLazySingleton<IngredientsService>(() => IngredientsService());
  getIt.registerLazySingleton<RestaurantsService>(() => RestaurantsService());
  getIt.registerLazySingleton<RestaurantTypeService>(() => RestaurantTypeService());
  getIt.registerLazySingleton<PatisseriesService>(() => PatisseriesService());
  getIt.registerLazySingleton<SuperMarktsService>(() => SuperMarktsService());
  getIt.registerLazySingleton<PressingService>(() => PressingService());
  getIt.registerLazySingleton<ProfessionnelService>(() => ProfessionnelService());
}
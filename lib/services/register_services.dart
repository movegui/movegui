


import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:movegui/config/env.dart';
import 'package:movegui/models/pricing_config_model.dart';
import 'package:movegui/services/form_services/adress_form_service.dart';
import 'package:movegui/services/adress_service.dart';
import 'package:movegui/services/api_service.dart';
import 'package:movegui/services/categories_service.dart';
import 'package:movegui/services/image_service.dart';
import 'package:movegui/services/ingredients_service.dart';
import 'package:movegui/services/localisation_service.dart';
import 'package:movegui/services/patisseries_service.dart';
import 'package:movegui/services/pressing_service.dart';
import 'package:movegui/services/pricing_service.dart';
import 'package:movegui/services/professionnel_service.dart';
import 'package:movegui/services/restaurant_type_service.dart';
import 'package:movegui/services/restaurants_service.dart';
import 'package:movegui/services/seed_service.dart';
import 'package:movegui/services/super_markts_service.dart';
import 'package:movegui/services/suppliers_service.dart';
import 'package:movegui/services/user_service.dart';

final getIt = GetIt.instance;

void initServices(Env env){
 // getIt.registerLazySingleton<CategoriesService>(() => CategoriesService());
 final api = ApiService(env: env, currency: 'GNF', dio: Dio(BaseOptions(baseUrl: env.baseUrl)));
 // getIt.registerLazySingleton<StoreCategoriesService>(() => StoreCategoriesService(api: api));
  getIt.registerLazySingleton<SuppliersService>(() => SuppliersService(api: api));
  getIt.registerLazySingleton<IngredientsService>(() => IngredientsService(api: api));
  getIt.registerLazySingleton<RestaurantsService>(() => RestaurantsService(api: api));
  getIt.registerLazySingleton<RestaurantTypeService>(() => RestaurantTypeService(api: api));
  getIt.registerLazySingleton<PatisseriesService>(() => PatisseriesService(api: api));
  getIt.registerLazySingleton<SuperMarktsService>(() => SuperMarktsService(api: api));
  getIt.registerLazySingleton<PressingService>(() => PressingService(api: api));
  getIt.registerLazySingleton<ProfessionnelService>(() => ProfessionnelService(api: api));
  getIt.registerLazySingleton<UserService>(() => UserService(api: api));
  getIt.registerLazySingleton<ImageService>(() => ImageService());
  getIt.registerLazySingleton<AdressService>(() => AdressService(api: api));
 // getIt.registerLazySingleton<PressingFormService>(() => PressingFormService(api: api));
  getIt.registerLazySingleton<SeedService>(() =>  SeedService(api: api, faker: Faker()));
  getIt.registerLazySingleton<CategoriesService> (() => CategoriesService(api: api));
  getIt.registerLazySingleton<PricingService>(() => PricingService( api: api , config: PricingConfigModel.fromRemote(),));
  getIt.registerLazySingleton<AdressFormService>(() => AdressFormService(api: api));
  getIt.registerLazySingleton<LocalisationService>(() => LocalisationService(api: api));


  //


  //
}
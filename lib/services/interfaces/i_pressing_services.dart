
 import 'package:movegui/models/pressing/pressing_service_model.dart';

abstract class IPressingServices  {
  Future<List<PressingServiceModel>> getAllServices(String id);
 }
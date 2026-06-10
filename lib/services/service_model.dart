

import 'package:movegui/models/model.dart';

abstract class ServiceModel extends Model{
  
  ServiceModel({required super.id, required super.name, required super.createdAt});

  
  String getCollectionName();
}
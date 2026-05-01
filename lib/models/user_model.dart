import 'package:movegui/models/model.dart';
import 'package:movegui/models/person_model.dart';

class UserModel extends Model {
  final String? username;
  final DateTime? updatedAt;
  final PersonModel? personModel;
  late bool isVerified;

  UserModel({
    required this.updatedAt,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.username,
    this.personModel,
    required this.isVerified
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'username': username,
    'updatedAt': updatedAt != null? updatedAt : null,
    'person': personModel!.toJson(),
    'isVerified': isVerified
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    createdAt: json['createdAt'].toDate(),
    username: json['username'],
    updatedAt: json['updateAt'],
    personModel: PersonModel.fromJson(json['person']),
    isVerified: json['isVerified'],
  );
}

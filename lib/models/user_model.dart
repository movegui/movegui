import 'package:hive/hive.dart';
import 'package:movegui/models/model.dart';
import 'package:movegui/models/person_model.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends Model {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final int pinCode;
  final PersonModel? personModel;

  UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.username,
    required this.password,
    required this.pinCode,
    this.personModel,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'username': username,
    'password': password,
    'pinCode': pinCode,
    'person': personModel!.toJson(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    createdAt: json['createdAt'].toDate(),
    username: json['username'],
    password: json['password'],
    pinCode: json['pinCode'],
    personModel: PersonModel.fromJson(json['person']),
  );
}

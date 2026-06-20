import 'package:movegui/models/model.dart';
import 'package:movegui/models/pressing/pressing_service_model.dart';

class PressingOrderArticleItem extends Model {
  final PressingServiceModel article;
  final int quantity;
  final Map<String, dynamic>? options;

  PressingOrderArticleItem({
    required super.id,
    required this.article,
    required this.quantity,
    this.options,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'article': article.toJson(),
    'quantity': quantity,
    'options': options,
  };

  factory PressingOrderArticleItem.fromJson(Map<String, dynamic> json) =>
      PressingOrderArticleItem(
        article: PressingServiceModel.fromJson(json['article']),
        id: json['id'],
        name: json['name'],
        createdAt:
            json['createdAt'] != null
                ? json['createdAt'].toDate()
                : DateTime.now(),
        quantity: json['quantity'],
        options:
            json['options'] != null
                ? Map<String, dynamic>.from(json['options'])
                : null,
      );
}

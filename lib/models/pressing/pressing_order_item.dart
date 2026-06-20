import 'package:movegui/models/model.dart';
import 'package:movegui/models/pressing/pressing_order_article_item.dart';
import 'package:movegui/models/pressing/pressing_service_type_model.dart';

class PressingOrderItem extends Model {
  final PressingServiceTypeModel serviceType;
  final List<PressingOrderArticleItem> articles;
  final double total;
  final String currency;

  PressingOrderItem({
    required this.serviceType,
    required this.articles,
    required this.total,
    required this.currency,
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'articles': articles.map((elem) => elem.toJson()).toList(),
    'service': serviceType.toJson(),
    'total': total,
    'currency': currency,
  };

  factory PressingOrderItem.fromJson(Map<String, dynamic> json) =>
      PressingOrderItem(
        serviceType: PressingServiceTypeModel.fromJson(json['service']),
        articles:
            (json['articles'] as List? ?? [])
                .map((e) => PressingOrderArticleItem.fromJson(e))
                .toList(),
        total: json['total'],
        currency: json['currency'],
        id: json['id'] ?? '001',
        name: json['name'] ?? 'sev1',
        createdAt:
            json['createdAt'] != null
                ? json['createdAt'].toDate()
                : DateTime.now(),
      );
}

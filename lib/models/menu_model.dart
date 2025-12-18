



class MenuModel extends Model {
  final String imageurl;
  final int restoId, categoryId;
  final List<ProductModel> products;

  MenuModel({
    required super.id, 
    required super.name,
    required this.imageurl,
    required this.restoId,
    required this.categoryId,
    required this.products,
    required super.createdAt
    });
  
}



/// Product category model
class ProductCategory {
  final String id;
  final String name;
  final String? parentId;
  final List<ProductCategory> subCategories;
  final List<Product> products;

  const ProductCategory({
    required this.id,
    required this.name,
    this.parentId,
    this.subCategories = const [],
    this.products = const [],
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      subCategories: (json['subCategories'] as List? ?? [])
          .map((cat) => ProductCategory.fromJson(cat as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List? ?? [])
          .map((prod) => Product.fromJson(prod as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'subCategories': subCategories.map((cat) => cat.toJson()).toList(),
      'products': products.map((prod) => prod.toJson()).toList(),
    };
  }
}

/// Product model class
class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String unit; // 'kg', 'g', 'piece', 'bottle', etc.
  final String categoryId;
  final bool isAvailable;
  final Map<String, dynamic>? nutritionInfo;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.unit,
    required this.categoryId,
    this.isAvailable = true,
    this.nutritionInfo,
  });

  /// Create Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] as String,
      categoryId: json['categoryId'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      nutritionInfo: json['nutritionInfo'] as Map<String, dynamic>?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'unit': unit,
      'categoryId': categoryId,
      'isAvailable': isAvailable,
      'nutritionInfo': nutritionInfo,
    };
  }

  /// Copy and modify Product
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    String? unit,
    String? categoryId,
    bool? isAvailable,
    Map<String, dynamic>? nutritionInfo,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
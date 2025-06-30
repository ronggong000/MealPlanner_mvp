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
  final double price;
  final String imageUrl;
  final String category;
  final String unit;
  final bool isAvailable;
  final Map<String, dynamic>? nutritionInfo;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.unit,
    this.isAvailable = true,
    this.nutritionInfo,
  });

  /// Create Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      unit: json['unit'] as String,
      isAvailable: json['isAvailable'] as bool,
      nutritionInfo: json['nutritionInfo'] as Map<String, dynamic>?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'unit': unit,
      'isAvailable': isAvailable,
      'nutritionInfo': nutritionInfo,
    };
  }

  /// Copy and modify Product
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    String? unit,
    bool? isAvailable,
    Map<String, dynamic>? nutritionInfo,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      unit: unit ?? this.unit,
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
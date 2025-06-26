import 'product.dart';

/// Shopping cart item model
class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final DateTime addedAt;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.addedAt,
  });

  /// Calculate total price
  double get totalPrice => product.price * quantity;

  /// Create CartItem instance from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  /// Copy and modify CartItem
  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Delivery address model
class DeliveryAddress {
  final String id;
  final String name;
  final String address;
  final String city;
  final String postalCode;
  final String phone;
  final bool isDefault;

  const DeliveryAddress({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phone,
    this.isDefault = false,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      phone: json['phone'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'phone': phone,
      'isDefault': isDefault,
    };
  }

  DeliveryAddress copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    String? postalCode,
    String? phone,
    bool? isDefault,
  }) {
    return DeliveryAddress(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      phone: phone ?? this.phone,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeliveryAddress && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
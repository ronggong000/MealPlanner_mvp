class InventoryItem {
  final String id;
  final String name;
  final String weight;
  final String? imageUrl;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.weight,
    this.imageUrl,
  });

  InventoryItem copyWith({
    String? id,
    String? name,
    String? weight,
    String? imageUrl,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'imageUrl': imageUrl,
    };
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      weight: json['weight'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

// Sample data
final List<InventoryItem> sampleInventoryItems = [
  InventoryItem(
    id: '1',
    name: 'Chicken Breast',
    imageUrl: 'assets/images/chicken_breast.jpg',
    weight: '500g',
  ),
  InventoryItem(
    id: '2',
    name: 'Ground Beef',
    imageUrl: 'assets/images/ground_beef.jpg',
    weight: '300g',
  ),
  InventoryItem(
    id: '3',
    name: 'Salmon',
    imageUrl: 'assets/images/salmon.jpg',
    weight: '400g',
  ),
  InventoryItem(
    id: '4',
    name: 'Tofu',
    imageUrl: 'assets/images/tofu.jpg',
    weight: '300g',
  ),
  InventoryItem(
    id: '5',
    name: 'Shrimp',
    imageUrl: 'assets/images/shrimp.jpg',
    weight: '300g',
  ),
  InventoryItem(
    id: '6',
    name: 'Pork',
    imageUrl: 'assets/images/pork.jpg',
    weight: '400g',
  ),
  InventoryItem(
    id: '7',
    name: 'Lamb',
    imageUrl: 'assets/images/lamb.jpg',
    weight: '500g',
  ),
  InventoryItem(
    id: '8',
    name: 'Duck',
    imageUrl: 'assets/images/duck.jpg',
    weight: '500g',
  ),
  InventoryItem(
    id: '9',
    name: 'Turkey',
    imageUrl: 'assets/images/turkey.jpg',
    weight: '500g',
  ),
]; 
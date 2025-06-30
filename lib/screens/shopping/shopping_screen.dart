import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../data/sample_data.dart';
import 'product_list_screen.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

/// Shopping category model
class ShoppingCategory {
  final String name;
  final String imageUrl;
  final IconData icon;

  const ShoppingCategory({
    required this.name,
    required this.imageUrl,
    required this.icon,
  });
}

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;
  late TabController _tabController;
  
  final List<ShoppingCategory> categories = const [
    ShoppingCategory(
      name: 'Produce',
      imageUrl: 'assets/images/fresh_from_farm.jpg',
      icon: Icons.eco,
    ),
    ShoppingCategory(
      name: 'Meat & Seafood',
      imageUrl: 'assets/images/meat_lover.jpg',
      icon: Icons.restaurant_menu,
    ),
    ShoppingCategory(
      name: 'Dairy & Eggs',
      imageUrl: 'assets/images/melbourne_combo.jpg',
      icon: Icons.egg,
    ),
    ShoppingCategory(
      name: 'Pantry',
      imageUrl: 'assets/images/italian.jpg',
      icon: Icons.kitchen,
    ),
    ShoppingCategory(
      name: 'Frozen Foods',
      imageUrl: 'assets/images/fish_and_fresh.jpg',
      icon: Icons.ac_unit,
    ),
    ShoppingCategory(
      name: 'Beverages',
      imageUrl: 'assets/images/fruit_major.jpg',
      icon: Icons.local_drink,
    ),
    ShoppingCategory(
      name: 'Snacks',
      imageUrl: 'assets/images/special_offers.jpg',
      icon: Icons.cookie,
    ),
    ShoppingCategory(
      name: 'Bakery',
      imageUrl: 'assets/images/pumkin_stew.jpg',
      icon: Icons.bakery_dining,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Get all products from all categories
  List<Product> get _allProducts {
    return [
      ...sampleProduceProducts,
      // Add other category products here when available
    ];
  }
  
  // Filter products based on search query
  List<Product> get _filteredProducts {
    if (_searchQuery.isEmpty) return [];
    
    final query = _searchQuery.toLowerCase();
    return _allProducts.where((product) {
      return product.name.toLowerCase().contains(query) ||
             product.description.toLowerCase().contains(query) ||
             product.category.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.pink[100],
          tabs: const [
            Tab(text: 'Catalog'),
            Tab(text: 'Cart'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Catalog Tab
          SingleChildScrollView(
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        _isSearching = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _isSearching ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                            _isSearching = false;
                          });
                        },
                      ) : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                
                // Search Results or Categories
                if (_isSearching)
                  // Search Results
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Results (${_filteredProducts.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return _buildProductCard(context, product);
                          },
                        ),
                      ],
                    ),
                  )
                else
                  // Categories Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return _buildCategoryCard(context, category);
                      },
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Cart Tab
          const CartScreen(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    ShoppingCategory category,
  ) {
    // Get products for the category
    List<Product> getCategoryProducts(String categoryName) {
      switch (categoryName) {
        case 'Produce':
          return sampleProduceProducts;
        case 'Meat & Seafood':
          return sampleMeatProducts;
        case 'Dairy & Eggs':
          return sampleDairyProducts;
        case 'Pantry':
          return samplePantryProducts;
        case 'Frozen Foods':
          return sampleFrozenProducts;
        case 'Beverages':
          return sampleBeverageProducts;
        case 'Snacks':
          return sampleSnackProducts;
        case 'Bakery':
          return sampleBakeryProducts;
        default:
          return [];
      }
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(
                category: category.name,
                products: getCategoryProducts(category.name),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(category.imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  category.icon,
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                product.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    height: 120,
                    child: Icon(
                      Icons.shopping_basket,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.pink[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}/${product.unit}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample product data
final List<Product> sampleProduceProducts = [
  Product(
    id: '1',
    name: 'Fresh Tomatoes',
    description: 'Ripe and juicy tomatoes, perfect for salads or cooking',
    price: 2.99,
    imageUrl: 'assets/images/veggie_curry.jpg',
    category: 'Produce',
    unit: 'lb',
  ),
  Product(
    id: '2',
    name: 'Organic Spinach',
    description: 'Fresh organic spinach leaves, rich in nutrients',
    price: 3.99,
    imageUrl: 'assets/images/fresh_from_farm.jpg',
    category: 'Produce',
    unit: 'bunch',
  ),
  // Add more produce items
];

final List<Product> sampleMeatProducts = [
  Product(
    id: '3',
    name: 'Chicken Breast',
    description: 'Boneless, skinless chicken breast, high in protein',
    price: 8.99,
    imageUrl: 'assets/images/chicken_breast.jpg',
    category: 'Meat & Seafood',
    unit: 'lb',
  ),
  Product(
    id: '4',
    name: 'Fresh Salmon',
    description: 'Wild-caught salmon fillet, rich in omega-3',
    price: 12.99,
    imageUrl: 'assets/images/salmon.jpg',
    category: 'Meat & Seafood',
    unit: 'lb',
  ),
  // Add more meat items
];

final List<Product> sampleDairyProducts = [
  Product(
    id: '5',
    name: 'Organic Eggs',
    description: 'Farm-fresh organic eggs from free-range chickens',
    price: 4.99,
    imageUrl: 'assets/images/avocado_toast.jpg',
    category: 'Dairy & Eggs',
    unit: 'dozen',
  ),
  // Add more dairy items
];

final List<Product> samplePantryProducts = [
  Product(
    id: '6',
    name: 'Quinoa',
    description: 'Organic white quinoa, high in protein and fiber',
    price: 5.99,
    imageUrl: 'assets/images/quinoa_salad.jpg',
    category: 'Pantry',
    unit: 'lb',
  ),
  // Add more pantry items
];

final List<Product> sampleFrozenProducts = [
  Product(
    id: '7',
    name: 'Frozen Mixed Vegetables',
    description: 'A blend of frozen vegetables, perfect for quick meals',
    price: 3.99,
    imageUrl: 'assets/images/fish_and_fresh.jpg',
    category: 'Frozen Foods',
    unit: 'bag',
  ),
  // Add more frozen items
];

final List<Product> sampleBeverageProducts = [
  Product(
    id: '8',
    name: 'Fresh Orange Juice',
    description: 'Freshly squeezed orange juice, no added sugar',
    price: 4.99,
    imageUrl: 'assets/images/fruit_major.jpg',
    category: 'Beverages',
    unit: 'bottle',
  ),
  // Add more beverage items
];

final List<Product> sampleSnackProducts = [
  Product(
    id: '9',
    name: 'Mixed Nuts',
    description: 'A healthy mix of premium nuts, perfect for snacking',
    price: 6.99,
    imageUrl: 'assets/images/tofu.jpg',
    category: 'Snacks',
    unit: 'bag',
  ),
  // Add more snack items
];

final List<Product> sampleBakeryProducts = [
  Product(
    id: '10',
    name: 'Fresh Baguette',
    description: 'Freshly baked French baguette',
    price: 2.99,
    imageUrl: 'assets/images/italian.jpg',
    category: 'Bakery',
    unit: 'piece',
  ),
  // Add more bakery items
];
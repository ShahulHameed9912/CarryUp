import 'package:carryup/views/productlist.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ProductCategory> recommendedCategories = [];
  List<ProductCategory> bestSellingCategories = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      fetchRecommendedCategories();
      fetchbestSellingCategories();
    });
  }

  void fetchRecommendedCategories() {
    recommendedCategories.add(ProductCategory(
      title: "Beauty",
      category: "beauty",
      price: "\$10",
      image: "assets/images/beauty.png",
    ));

    recommendedCategories.add(
      ProductCategory(
        title: "Footwears",
        category: "mens-shoes",
        price: "\$89",
        image: "assets/images/shoe.png",
      ),
    );

    recommendedCategories.add(
      ProductCategory(
        title: "Watches",
        category: "mens-watches",
        price: "\$199",
        image: "assets/images/smartwatch.png",
      ),
    );
  }

  void fetchbestSellingCategories() {
    bestSellingCategories.add(
      ProductCategory(
        title: "Tshirts",
        category: "mens-shirts",
        price: "\$10",
        image: "assets/images/tshirt.png",
      ),
    );

    bestSellingCategories.add(
      ProductCategory(
        title: "Furnitures",
        category: "furniture",
        price: "\$2000",
        image: "assets/images/furniture.png",
      ),
    );

    bestSellingCategories.add(
      ProductCategory(
        title: "Smart Phones",
        category: "smartphones",
        price: "\$199",
        image: "assets/images/mobile.png",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2228),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchBar(),
              const SizedBox(height: 20),
              _promoBanner(),
              const SizedBox(height: 20),
              _categories(),
              const SizedBox(height: 24),
              _sectionHeader("Recommended for You"),
              const SizedBox(height: 16),
              _recommendedProducts(),
              const SizedBox(height: 16),
              _sectionHeader("Best Selling"),
              const SizedBox(height: 16),
              _bestSelling(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: const Icon(Icons.tune, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF2A2F38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  /// 🎉 Promo Banner
  Widget _promoBanner() {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 248, 116, 0), Color(0xFFF39C12)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Up to 50% Off",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  "Super Sale",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Shop Now",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/banner.png',
            height: 150,
            width: 180,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  /// 🧩 Categories
  Widget _categories() {
    final categories = [
      Icons.grid_view,
      Icons.checkroom,
      Icons.hiking,
      Icons.phone_iphone,
      Icons.chair,
    ];

    final labels = ["all", "Clothing", "Shoes", "Tech", "Furniture"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(categories.length, (index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2F38),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                categories[index],
                color: index == 0 ? const Color(0xFFFF9F1C) : Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              labels[index],
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        );
      }),
    );
  }

  /// 📌 Section Header
  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    );
  }

  /// 🛍 Recommended Products
  Widget _recommendedProducts() {
    return SizedBox(
      height: 240,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: recommendedCategories.map((category) {
          return ProductCard(
            title: category.title,
            price: category.price,
            icon: category.image,
            category: category.category,
          );
        }).toList(),
      ),
    );
  }

  /// 🛍 Recommended Products
  Widget _bestSelling() {
    return SizedBox(
      height: 240,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: bestSellingCategories.map((category) {
          return ProductCard(
            title: category.title,
            price: category.price,
            icon: category.image,
            category: category.category,
          );
        }).toList(),
      ),
    );
  }
}

/// 🧱 Product Card Widget
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String icon;
  final String category;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.icon,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Productlist(
                      category: category,
                    )),
          );
        },
        child: Container(
          width: 180,
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2F38),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image Section
              Expanded(
                child: Center(
                  child: Image.asset(icon, height: 110, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 12),

              /// Title
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// Price
              Text(
                "Starting from $price",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCategory {
  String title;
  String category;
  String price;
  String image;

  ProductCategory({
    required this.title,
    required this.category,
    required this.price,
    required this.image,
  });
}

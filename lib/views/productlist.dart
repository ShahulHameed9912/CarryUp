import 'package:carryup/apiservices/api_service_manager.dart';
import 'package:carryup/models/product.dart';
import 'package:carryup/views/commonwidgets/appbar.dart';
import 'package:flutter/material.dart';

class Productlist extends StatefulWidget {
  final String category;

  const Productlist({
    super.key,
    required this.category,
  });

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  final List<Product> fetchedProducts = [];

  @override
  void initState() {
    super.initState();

    apiServiceManager
        .getProductsbyCategory(widget.category)
        .then((productResponse) {
      // Handle the product response here
      if (productResponse != null && productResponse.products != null) {
        // For example, you can print the products
        setState(() {
          fetchedProducts.addAll(productResponse.products!);
        });
      } else {
        print('Failed to fetch products.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F24),
      appBar: AppbarWidget(title: "Shoes", isProfile: false),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.60,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: fetchedProducts.length,
        itemBuilder: (context, index) {
          return ProductItemCard(product: fetchedProducts[index]);
        },
      ),
    );
  }
}

class ProductItemCard extends StatefulWidget {
  final Product product;

  const ProductItemCard({super.key, required this.product});

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F38),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE SLIDER + INDICATORS
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: product.images!.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: Image.network(
                        product.images![index],
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 100),

              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.favorite,
                  color: Colors.orange,
                  size: 20,
                ),
              ),

              /// Indicators
              Positioned(
                bottom: 6,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    product.images!.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentIndex == index ? 14 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.orange
                            : Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              /// Favorite icon
            ],
          ),

          const SizedBox(height: 10),

          /// TITLE
          Text(
            product.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 4),

          /// PRICE
          Text(
            "\$${product.price}",
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 4),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

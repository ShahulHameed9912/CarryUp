import 'package:carryup/apiservices/api_service_manager.dart';
import 'package:carryup/models/cartProducts.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartProducts> cart = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    apiServiceManager.getCarts().then((cartsResponse) {
      setState(() {
        cart = cartsResponse!.products!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2228),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔒 FIXED HEADER
            _header(),

            // 🔒 FIXED SUMMARY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _summaryCard(),
            ),

            const SizedBox(height: 12),

            // 🔄 SCROLLABLE CART ITEMS
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _cartItem(
                      image: item.thumbnail!,
                      title: item.title ?? 'Product',
                      price: '\$${item.price ?? 0}',
                      count: item.quantity!,
                    ),
                  );
                },
              ),
            ),

            // 🔒 FIXED CHECKOUT BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: _checkoutButton(),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Cart',
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ---------------- CART ITEM ----------------
  Widget _cartItem({
    required String image,
    required String title,
    required String price,
    required int count,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 38, 38, 39),
            Color.fromARGB(255, 153, 153, 160)
          ],
        ),
      ),
      child: Row(
        children: [
          Image.network(image, width: 70),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(price,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _qtyControl(count),
              const SizedBox(height: 8),
              const Text(
                'Remove',
                style: TextStyle(
                    color: Color(0xFFFFA726),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _qtyControl(int count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                count -= 1;
              });
            },
            child: const QtyButton(Icons.remove),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text("$count",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                count += 1;
              });
            },
            child: const QtyButton(Icons.add),
          ),
        ],
      ),
    );
  }

  // ---------------- SUMMARY ----------------
  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 38, 38, 39),
            Color.fromARGB(255, 153, 153, 160)
          ],
        ),
      ),
      child: Column(
        children: [
          _row('Subtotal', '\$164.00'),
          const SizedBox(height: 8),
          _row('Shipping', 'Free', highlight: true),
          const Divider(color: Colors.white24, height: 24),
          _row('Total', '\$164.00', bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {bool bold = false, bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: Colors.white70,
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value,
            style: TextStyle(
                color: highlight ? const Color(0xFFFFA726) : Colors.white,
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _checkoutButton() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB74D), Color(0xFFF57C00)],
        ),
      ),
      child: const Center(
        child: Text(
          'Checkout',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class QtyButton extends StatelessWidget {
  final IconData icon;
  const QtyButton(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}

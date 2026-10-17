import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _remove(Product product) {
    setState(() => Cart.remove(product));
  }

  void _checkout() {
    setState(() => Cart.clear());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed! (simulation)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = Cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: items.isEmpty
          ? const _EmptyCart()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey.shade100,
                      padding: const EdgeInsets.all(6),
                      child: ProductImage(path: product.imageAsset),
                    ),
                  ),
                  title: Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${product.tagline}\n${product.price}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _remove(product),
                  ),
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        items.isEmpty
                            ? 'Your cart is empty.'
                            : '${items.length} item(s) • Total: \$${Cart.total.toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: items.isEmpty ? null : _checkout,
                  child: const Text('Checkout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text('Your cart is empty',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Add items to start shopping',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
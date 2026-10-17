import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../models/product.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void _toggleCart(Product product) {
    final wasInCart = Cart.contains(product);
    setState(() {
      if (wasInCart) {
        Cart.remove(product);
      } else {
        Cart.add(product);
      }
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(wasInCart
              ? '${product.name} removed from cart'
              : '${product.name} added to cart'),
          duration: const Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Route Arguments: ana sayfadan gelen ürünü al
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final inCart = Cart.contains(product);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.grey.shade100,
            padding: const EdgeInsets.all(24),
            child: ProductImage(path: product.imageAsset),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(product.tagline,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(height: 1.5, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Specifications',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.specs.entries
                      .map((e) => _SpecBox(label: e.key, value: e.value))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                product.price,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          inCart ? Colors.grey.shade300 : Colors.black,
                      foregroundColor: inCart ? Colors.black : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _toggleCart(product),
                    child: Text(inCart ? 'Remove from Cart' : 'Add to Cart'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecBox extends StatelessWidget {
  const _SpecBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(),
              style: const TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
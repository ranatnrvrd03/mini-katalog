import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  String _query = '';
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ProductRepository.loadProducts();
      if (!mounted) return;
      setState(() {
        _products = products;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Products could not be loaded: $e';
        _loading = false;
      });
    }
  }

  // Basit arama / filtreleme
  List<Product> get _filteredProducts {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _products;
    return _products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.tagline.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _openDetail(Product product) async {
    // Route Arguments: ürünü detay sayfasına gönder
    await Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
    if (!mounted) return;
    setState(() {}); // Geri dönünce sepet rozetini güncelle
  }

  Future<void> _openCart() async {
    await Navigator.pushNamed(context, CartScreen.routeName);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_loading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(_error!),
        ),
      );
    } else {
      content = _buildContent();
    }

    return Scaffold(body: SafeArea(child: content));
  }

  Widget _buildContent() {
    final products = _filteredProducts;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildSearchField(),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
        ),
        const SizedBox(height: 16),
        if (products.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: Text('No products found')),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () => _openDetail(product),
              );
            },
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                'Find your perfect device.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: _openCart,
          icon: Badge(
            isLabelVisible: Cart.count > 0,
            label: Text('${Cart.count}'),
            child: const Icon(Icons.shopping_bag_outlined, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) => setState(() => _query = value),
      decoration: InputDecoration(
        hintText: 'Search products',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
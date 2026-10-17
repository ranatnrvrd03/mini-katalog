import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';

class ProductRepository {
  // JSON simülasyonu: assets içindeki dosyadan ürünleri okur
  static Future<List<Product>> loadProducts() async {
    final jsonText = await rootBundle.loadString('assets/data/products.json');
    final decoded = jsonDecode(jsonText) as Map<String, dynamic>;
    final data = decoded['data'] as List<dynamic>;
    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
import '../models/product.dart';

// Basit sepet simülasyonu: tüm ekranların ortak kullandığı liste
class Cart {
  Cart._();

  static final List<Product> items = [];

  static int get count => items.length;

  static double get total =>
      items.fold(0, (sum, product) => sum + product.priceValue);

  static bool contains(Product product) =>
      items.any((p) => p.id == product.id);

  static void add(Product product) {
    if (!contains(product)) items.add(product);
  }

  static void remove(Product product) =>
      items.removeWhere((p) => p.id == product.id);

  static void clear() => items.clear();
}
class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price; // Örn: "$999"
  final String imageUrl;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.specs,
  });

  // Görselin assets klasöründeki yolu: ".../iphone.png" → "assets/images/iphone.png"
  String get imageAsset => 'assets/images/${imageUrl.split('/').last}';

  // "$2,499" → 2499.0 (sepet toplamı için)
  double get priceValue =>
      double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = json['specs'] as Map<String, dynamic>? ?? {};
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tagline': tagline,
        'description': description,
        'price': price,
        'image': imageUrl,
        'specs': specs,
      };
}
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.path, this.fit = BoxFit.contain});

  final String path;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => const Center(
        child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../shared/presentation/widget/product_item.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  const ProductsByCategoryScreen({super.key, required this.categoryName});

  static const String name = '/product-by-category';

  final String categoryName;

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4
          ),
          itemBuilder: (context, index) {
            return ProductItem();
          },
        ),
      ),
    );
  }
}

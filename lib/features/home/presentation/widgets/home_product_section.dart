import 'package:flutter/material.dart';

import '../../../shared/presentation/widget/product_item.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({super.key, required this.products});

  final List<String> products;

  @override
  Widget build(BuildContext context) {
    return ProductItem();
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          return ProductItems();
        },
      ),
    );
  }
}
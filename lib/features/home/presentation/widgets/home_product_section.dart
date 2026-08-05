import 'package:flutter/material.dart';

import '../../../shared/presentation/widget/product_item.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({super.key, required this.products});

  final List<String> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 192,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: .horizontal,
        itemBuilder: (context, index) {
          return SizedBox(width: 144, child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ProductItem(),
          ));
        },
      ),
    );
  }
}

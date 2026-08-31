import 'package:flutter/material.dart';

import '../../../products/data/models/product_model.dart';
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
          return SizedBox(
            width: 144,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              // child: ProductItem(
              //   product: ProductModel(
              //     id: '67b4bcc98dc27a1d294a27a9',
              //     title: 'Adidas shoe',
              //     photos: [],
              //     currentPrice: 10000,
              //     quantity: 20,
              //     rating: 4.5,
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }
}

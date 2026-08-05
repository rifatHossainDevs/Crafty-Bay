import 'package:crafty_bay/features/products/presentation/widgets/product_image_carousel.dart';
import 'package:flutter/material.dart';

import '../widgets/product_details/price_and_add_to_cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),

      body: Column(
        children: [
          Expanded(child: Column(children: [ProductImageCarousel()])),
          PriceAndAddToCartSection(),
        ],
      ),
    );
  }
}

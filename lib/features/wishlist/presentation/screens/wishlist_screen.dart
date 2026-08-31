import 'package:crafty_bay/features/shared/presentation/providers/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/data/models/product_model.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WishList"),
        leading: IconButton(
          onPressed: () {
            context.read<MainNavHolderProvider>().backToHome();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .7,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return ProductItem(
              productModel: ProductModel(
                id: '67b4bcc98dc27a1d294a27a9',
                title: 'Adidas shoe',
                photos: [],
                currentPrice: 10000,
                quantity: 20,
                rating: 4.5,
              ),
            );
          },
        ),
      ),
    );
  }
}

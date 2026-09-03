import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_holder_provider.dart';
import '../providers/cart_item_provider.dart';
import '../widget/cart_item.dart';
import '../widget/total_price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartItemProvider _cartItemProvider = CartItemProvider();

  @override
  void initState() {
    super.initState();
    _cartItemProvider.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _cartItemProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          leading: IconButton(
            onPressed: () {
              context.read<MainNavHolderProvider>().backToHome();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: Consumer<CartItemProvider>(
                builder: (context, _, _) {
                  return ListView.builder(
                    itemCount: _cartItemProvider.cartItem.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        cartItemModel: _cartItemProvider.cartItem[index],
                      );
                    },
                  );
                },
              ),
            ),
            TotalPriceAndCheckoutSection(),
          ],
        ),
      ),
    );
  }
}

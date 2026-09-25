import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/providers/cart_item_provider.dart';
import '../../../cart/presentation/widget/cart_item.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../providers/create_order_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const String name = '/order-screen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CartItemProvider _cartItemProvider = CartItemProvider();
  final CreateOrderProvider _createOrderProvider = CreateOrderProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartItemProvider.getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _cartItemProvider),
        ChangeNotifierProvider.value(value: _createOrderProvider),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Consumer2<CartItemProvider, CreateOrderProvider>(
          builder: (context, cartItemProvider, createOrderProvider, _) {
            if (cartItemProvider.cartLoading) {
              return CenteredProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemProvider.cartItem.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        cartItemModel: cartItemProvider.cartItem[index],
                      );
                    },
                  ),
                ),


              ],
            );
          },
        ),
      ),
    );
  }
}

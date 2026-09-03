import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';
import '../../../shared/presentation/widget/no_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: AppColors.themeColor.withAlpha(50),
      margin: .symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: cartItemModel.product.photos[0],
              width: 100,
              height: 100,
              errorWidget: (_, _, __) => NoImage(),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              cartItemModel.product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text('Size: ${cartItemModel.size} Color: ${cartItemModel.color}'),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "${Constants.takaSign} ${cartItemModel.product.currentPrice}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      SizedBox(
                        width: 88,
                        child: IncDecButton(
                          initialValue: cartItemModel.quantity,
                          onChange: (int value) {},
                          maxValue: 100,
                          minValue: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

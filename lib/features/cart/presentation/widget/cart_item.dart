import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';
import '../../../shared/presentation/widget/no_image.dart';
import '../../data/models/cart_item_model.dart';
import '../providers/cart_item_provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: AppColors.themeColor.withAlpha(50),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: _getImageUrl(widget.cartItemModel.product.photos),
              width: 100,
              height: 100,
              errorWidget: (_, _, _) => const NoImage(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartItemModel.product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Size: ${widget.cartItemModel.size} Color: ${widget.cartItemModel.color}',
                            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Constants.takaSign} ${widget.cartItemModel.product.currentPrice}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      SizedBox(
                        width: 88,
                        child: IncDecButton(
                          initialValue: 1,
                          onChange: (int value) {
                            context.read<CartItemProvider>().increaseProductQuantity(value, widget.cartItemModel.id);
                          },
                          maxValue: 20,
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

  String _getImageUrl(List<String> urls){
    return urls.isNotEmpty? urls.first: '';
  }
}

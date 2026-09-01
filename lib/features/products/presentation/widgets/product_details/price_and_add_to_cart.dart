import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/constants.dart';
import '../../../../cart/presentation/providers/add_to_cart_provider.dart';

class PriceAndAddToCartSection extends StatelessWidget {
  const PriceAndAddToCartSection({
    super.key,
    required this.price,
    required this.onAddCart,
  });

  final int price;
  final VoidCallback onAddCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withAlpha(30),
        borderRadius: .only(topLeft: .circular(20), topRight: .circular(20)),
      ),
      padding: .all(16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Price', style: TextStyle(fontWeight: .w600)),
              Text(
                '${Constants.takaSign}$price',
                style: TextStyle(
                  fontWeight: .w600,
                  fontSize: 20,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: Consumer<AddToCartProvider>(
              builder: (context, addToCartProvider, _) {
                if (addToCartProvider.addToCartInProgress) {
                  return CenteredProgressIndicator();
                }
                return FilledButton(
                  onPressed: onAddCart,
                  child: Text("Add to Cart"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

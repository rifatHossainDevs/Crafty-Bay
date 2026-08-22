import 'package:flutter/material.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/constants.dart';

class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({super.key});

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
              Text('Total Price', style: TextStyle(fontWeight: .w600)),
              Text(
                '${Constants.takaSign}10000',
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
            child: FilledButton(onPressed: () {}, child: Text("Checkout")),
          ),
        ],
      ),
    );
  }
}

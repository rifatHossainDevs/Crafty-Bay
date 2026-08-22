import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/assets_paths.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

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
            child: Image.asset(AssetsPaths.shoePng, width: 100),
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
                              'Title of the Product',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text('Size: XL Color: Red'),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "${Constants.takaSign} 100",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      SizedBox(
                        width: 88,
                        child: IncDecButton(
                          initialValue: 1,
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

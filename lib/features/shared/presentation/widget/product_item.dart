import 'package:crafty_bay/features/products/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/assets_paths.dart';
import '../../../../app/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.name);
      },
      child: Card(
        elevation: 3,
        shadowColor: AppColors.themeColor.withAlpha(40),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.themeColor.withAlpha(20),
                borderRadius: .only(
                  topLeft: .circular(8),
                  topRight: .circular(8),
                ),
              ),
              padding: .all(8),
              child: Image.asset(AssetsPaths.shoePng, fit: BoxFit.cover),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Title of product",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w500,
                      color: Colors.black54,
                      overflow: .ellipsis,
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          "${Constants.takaSign}100",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: .w500,
                            color: AppColors.themeColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Text("4.8"),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(4),
                          ),
                          color: AppColors.themeColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../app/app_colors.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screens.dart';
import '../screens/add_new_reviews_screen.dart';

class ProductReviewsCountCart extends StatelessWidget {
  const ProductReviewsCountCart({super.key, required this.reviewsCount, required this.productId});

  final int reviewsCount;
  final String productId;

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
              Text(
                'Reviews ($reviewsCount)',
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              minimumSize: const Size(48, 48),
              shape: const CircleBorder(),
            ),
            onPressed: () async {
              bool isLoggedIn = await AuthController.isLoggedIn();

              if (isLoggedIn == false) {
                Navigator.pushNamed(context, SignInScreens.name);
              }
              Navigator.pushNamed(context, AddNewReviewsScreen.name, arguments: productId);
            },

            child: Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }
}

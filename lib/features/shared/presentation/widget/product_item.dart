import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/features/wishlist/data/models/wishlist_param.dart';
import 'package:crafty_bay/features/wishlist/presentation/providers/add_to_wishlist_provider.dart';
import 'package:crafty_bay/features/wishlist/presentation/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screens.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/presentation/screens/product_details_screen.dart';
import 'centered_progress_indicator.dart';
import 'no_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: Card(
        color: Colors.white,
        shadowColor: AppColors.themeColor.withAlpha(30),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.themeColor.withAlpha(20),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: .circular(8),
                child: CachedNetworkImage(
                  height: 110,
                  imageUrl: _getPhotoPath(productModel.photos),
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) => const NoImage(),
                  progressIndicatorBuilder: (_, _, _) => const NoImage(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}${productModel.currentPrice}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          Text(
                            '${productModel.rating}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          final isLoggedIn = await AuthController.isLoggedIn();
                          if (isLoggedIn == false) {
                            Navigator.pushNamed(context, SignInScreens.name);
                            return;
                          }

                          final addToWishlistProvider =
                              context.read<AddToWishlistProvider>();
                          final wishlistProvider =
                              context.read<WishlistProvider>();

                          final bool result =
                              await addToWishlistProvider.addToWishList(
                            WishlistParam(productId: productModel.id),
                          );

                          if (result) {
                            wishlistProvider.refreshWishlistProductList();
                            showSnackBarMessage(
                                context, "Product added to wishlist");
                          } else {
                            showSnackBarMessage(
                                context, addToWishlistProvider.errorMessage!);
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          margin: EdgeInsets.zero,
                          color: AppColors.themeColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Consumer2<AddToWishlistProvider,
                                WishlistProvider>(
                              builder: (context, addToWishlistProvider,
                                  wishlistProvider, _) {
                                if (addToWishlistProvider.isLoading) {
                                  return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  );
                                }

                                bool isFavorite = wishlistProvider
                                    .isProductInWishlist(productModel.id);

                                return Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 10,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPhotoPath(List<String> photos) {
    return photos.length > 0 ? photos.first : '';
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extension/utility_extension.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screens.dart';
import '../../../cart/data/models/add_to_cart_params.dart';
import '../../../cart/presentation/providers/add_to_cart_provider.dart';
import '../../../reviews/presentation/screens/reviews_screen.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';
import '../../../shared/presentation/widget/snack_bar_message.dart';
import '../../../wishlist/data/models/wishlist_param.dart';
import '../../../wishlist/presentation/providers/add_to_wishlist_provider.dart';
import '../../../wishlist/presentation/providers/wishlist_provider.dart';
import '../providers/product_details_provider.dart';
import '../widgets/product_details/color_picker.dart';
import '../widgets/product_details/price_and_add_to_cart.dart';
import '../widgets/product_details/size_picker.dart';
import '../widgets/product_image_carousel.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name = '/product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();

  final AddToCartProvider _addToCartProvider = AddToCartProvider();

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    _productDetailsProvider.getProductDetails(widget.productId);
    super.initState();
  }

  void _addToWishlist() async {
    final isLoggedIn = await AuthController.isLoggedIn();

    if (isLoggedIn == false) {
      if (!mounted) return;
      showSnackBarMessage(context, context.localization.loginFirstToAddToWishlist);
      Navigator.pushNamed(context, SignInScreens.name);
      return;
    }
    final addToWishlistProvider = context.read<AddToWishlistProvider>();
    final bool result = await addToWishlistProvider.addToWishList(
      WishlistParam(productId: widget.productId),
    );
    if (!mounted) {
      return;
    }
    if (result) {
      context.read<WishlistProvider>().refreshWishlistProductList();
      showSnackBarMessage(context, context.localization.productAddedToWishlist);
    } else {
      showSnackBarMessage(context, addToWishlistProvider.errorMessage!);
    }
  }

  void _addToCart() async {
    final isLoggedIn = await AuthController.isLoggedIn();

    if (isLoggedIn == false) {
      if (!mounted) return;
      Navigator.pushNamed(context, SignInScreens.name);
      return;
    }

    final bool result = await _addToCartProvider.addToCart(
      AddToCartParams(
        productId: widget.productId,
        color: _selectedColor ?? "",
        size: _selectedSize ?? "",
        quantity: _quantity,
      ),
    );

    if (!mounted) {
      return;
    }

    if (result) {
      showSnackBarMessage(context, context.localization.productAddedToCart);
    } else {
      showSnackBarMessage(context, _addToCartProvider.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _productDetailsProvider),
        ChangeNotifierProvider.value(value: _addToCartProvider),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.productDetails),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.isLoading) {
              return const CenteredProgressIndicator();
            }

            final productDetails = _productDetailsProvider.productDetailsModel!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(images: productDetails.photos),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      productDetails.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: IncDecButton(
                                      initialValue: 1,
                                      onChange: (int value) {
                                        _quantity = value;
                                      },
                                      maxValue: 10,
                                      minValue: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Text("4.8"),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        ReviewsScreen.name,
                                        arguments: widget.productId,
                                      );
                                    },
                                    child: Text(context.localization.reviews),
                                  ),
                                  const SizedBox(width: 8),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    color: AppColors.themeColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: GestureDetector(
                                        onTap: () {
                                          _addToWishlist();
                                        },
                                        child: Consumer2<AddToWishlistProvider,
                                            WishlistProvider>(
                                          builder: (context,
                                              addToWishlistProvider,
                                              wishlistProvider,
                                              _) {
                                            if (addToWishlistProvider
                                                .isLoading) {
                                              return const SizedBox(
                                                height: 16,
                                                width: 16,
                                                child:
                                                    CenteredProgressIndicator(),
                                              );
                                            }

                                            bool isFavorite = wishlistProvider
                                                .isProductInWishlist(
                                                    widget.productId);

                                            return Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.white,
                                              size: 16,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(context.localization.color, style: textTheme.labelLarge),
                              const SizedBox(height: 8),
                              ColorPicker(
                                colors: productDetails.colors,
                                onChange: (String selectedColor) {
                                  _selectedColor = selectedColor;
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(context.localization.size, style: textTheme.labelLarge),
                              const SizedBox(height: 8),
                              SizePicker(
                                sizes: productDetails.sizes,
                                onChange: (String selectedSize) {
                                  _selectedSize = selectedSize;
                                  debugPrint(selectedSize);
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(context.localization.description, style: textTheme.labelLarge),
                              const SizedBox(height: 8),
                              Text(
                                productDetails.description,
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PriceAndAddToCartSection(
                  price: productDetails.currentPrice,
                  onAddCart: _addToCart,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
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
  final AddToWishlistProvider _addToWishlistProvider = AddToWishlistProvider();
  final WishlistProvider _wishlistProvider = WishlistProvider();

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    _productDetailsProvider.getProductDetails(widget.productId);
    _wishlistProvider.getWishListProducts();
    super.initState();
  }

  void _addToWishlist() async {
    final isLoggedIn = await AuthController.isLoggedIn();

    if (isLoggedIn == false) {
      if (!mounted) return;
      showSnackBarMessage(context, "Login first to add to wishlist");
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
      _wishlistProvider.refreshWishlistProductList();
      showSnackBarMessage(context, "Product added to wishlist");
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
      showSnackBarMessage(context, "Product added to cart");
    } else {
      showSnackBarMessage(context, _addToCartProvider.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _productDetailsProvider),
        ChangeNotifierProvider.value(value: _addToCartProvider),
        ChangeNotifierProvider.value(value: _addToWishlistProvider),
        ChangeNotifierProvider.value(value: _wishlistProvider),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Details"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),

        body: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.isLoading) {
              return CenteredProgressIndicator();
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
                            crossAxisAlignment: .start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      productDetails.title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: .w600,
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
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Text("4.8"),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        ReviewsScreen.name,
                                        arguments: widget.productId,
                                      );
                                    },
                                    child: Text("Reviews"),
                                  ),
                                  const SizedBox(width: 8),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: .circular(4),
                                    ),
                                    color: AppColors.themeColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: GestureDetector(
                                        onTap: () {
                                          _addToWishlist();
                                        },

                                        child:
                                            Consumer2<
                                              AddToWishlistProvider,
                                              WishlistProvider
                                            >(
                                              builder:
                                                  (
                                                    context,
                                                    addToWishlistProvider,
                                                    wishlistProvider,
                                                    _,
                                                  ) {
                                                    if (addToWishlistProvider
                                                        .isLoading) {
                                                      return SizedBox(
                                                        height: 16,
                                                        width: 16,
                                                        child:
                                                            CenteredProgressIndicator(),
                                                      );
                                                    }

                                                    bool isFavorite =
                                                        wishlistProvider
                                                            .isProductInWishlist(
                                                              widget.productId,
                                                            );

                                                    return Icon(
                                                      isFavorite
                                                          ? Icons.favorite
                                                          : Icons
                                                                .favorite_border,
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
                              Text(
                                "Color",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ColorPicker(
                                colors: productDetails.colors,
                                onChange: (String selectedColor) {
                                  _selectedColor = selectedColor;
                                },
                              ),

                              const SizedBox(height: 16),
                              Text(
                                "Size",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizePicker(
                                sizes: productDetails.sizes,
                                onChange: (String selectedSize) {
                                  _selectedSize = selectedSize;
                                  debugPrint(selectedSize);
                                },
                              ),

                              const SizedBox(height: 16),
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                productDetails.description,
                                style: TextStyle(color: Colors.black54),
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

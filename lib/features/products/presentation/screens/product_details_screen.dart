import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screens.dart';
import 'package:crafty_bay/features/cart/data/models/add_to_cart_params.dart';
import 'package:crafty_bay/features/cart/presentation/providers/add_to_cart_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/inc_dec_button.dart';
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

  void _addToCart() async {
    final isLoggedIn = await AuthController.isLoggedIn();

    debugPrint("Is logged in: $isLoggedIn");
    debugPrint("Access token: ${AuthController.accessToken}");

    if (await AuthController.isLoggedIn() == false) {
      debugPrint("User is NOT logged in");
      if (!mounted) return;
      Navigator.pushNamed(context, SignInScreens.name);
      return;
    }

    debugPrint("User IS logged in");

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
                                    onPressed: () {},
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
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 16,
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

import 'package:crafty_bay/features/products/presentation/widgets/product_details/color_picker.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_details/size_picker.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/shared/presentation/widget/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../widgets/product_details/price_and_add_to_cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageCarousel(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nike new shoe 2027 - AK2323RRR',
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
                                onChange: (int value) {},
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
                                Icon(Icons.star, color: Colors.amber, size: 20),
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
                          colors: ['Red', 'Green', 'Blue', 'Black', 'White'],
                          onChange: (String selectedColor) {},
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
                          sizes: ['M', 'L', 'XL', 'XXL', '2XL'],
                          onChange: (String selectedSize) {
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
                          '''Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.''',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          PriceAndAddToCartSection(),
        ],
      ),
    );
  }
}

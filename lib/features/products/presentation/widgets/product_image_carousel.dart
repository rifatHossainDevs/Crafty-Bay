import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widget/no_image.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            viewportFraction: .9,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            autoPlay: false,
            autoPlayCurve: Curves.linear,
            autoPlayInterval: Duration(seconds: 5),
            reverse: false,
            scrollDirection: .horizontal,
          ),
          items: widget.images.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  alignment: .center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(50),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: .scaleDown,
                    errorWidget: (_, _, _) => const NoImage(),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Positioned(
          right: 0,
          left: 0,
          bottom: 8,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: .center,
                children: [
                  for (int i = 0; i < widget.images.length; i++)
                    Container(
                      width: 10,
                      height: 10,
                      margin: .only(right: 4),
                      decoration: BoxDecoration(
                        color: value == i ? AppColors.themeColor : Colors.white,
                        shape: .circle,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

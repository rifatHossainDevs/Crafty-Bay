import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({super.key});

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
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  alignment: .center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(50),
                  ),
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                  for (int i = 0; i < 5; i++)
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

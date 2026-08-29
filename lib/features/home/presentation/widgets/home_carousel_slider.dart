import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/no_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../providers/home_sliders_provider.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSlidersProvider>(
      builder: (context, homeSlidersProvider, _) {
        if (homeSlidersProvider.getHomeSlidersInProgress) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: .9,
                onPageChanged: (index, reason) {
                  _currentIndex.value = index;
                },
                autoPlay: true,
                autoPlayCurve: Curves.linear,
                autoPlayInterval: Duration(seconds: 5),
                reverse: false,
                scrollDirection: .horizontal,
              ),
              items: homeSlidersProvider.sliders.map((slide) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: .circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: .circular(12),
                        child: CachedNetworkImage(
                          imageUrl: slide.photoUrl,
                          fit: .cover,
                          errorWidget: (_, _, _) => NoImage(),
                          progressIndicatorBuilder: (_, _, _)=> NoImage(),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: .center,
                  children: [
                    for (int i = 0; i < homeSlidersProvider.sliders.length; i++)
                      Container(
                        width: 10,
                        height: 10,
                        margin: .only(right: 2),
                        decoration: BoxDecoration(
                          color: value == i ? AppColors.themeColor : null,
                          shape: .circle,
                          border: .all(color: Colors.grey),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}

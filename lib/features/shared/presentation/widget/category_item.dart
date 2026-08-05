import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/assets_paths.dart';
import '../../../../app/extension/utility_extension.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: .all(20),
          alignment: .center,
          decoration: BoxDecoration(
            color: AppColors.themeColor.withAlpha(30),
            borderRadius: .circular(12),
          ),
          child: SvgPicture.asset(
            AssetsPaths.electronicsSvg,
            width: 44,
            height: 44,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _getTitle("Electronics"),
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.themeColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  String _getTitle(String category) {
    if (category.length > 11) {
      return '${category.substring(0, 10)}...';
    } else {
      return category;
    }
  }
}

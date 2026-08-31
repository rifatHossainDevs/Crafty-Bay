import 'package:cached_network_image/cached_network_image.dart';
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/products/presentation/screens/products_by_category_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extension/utility_extension.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductsByCategoryScreen.name,
          arguments: category,
        );
      },
      child: Column(
        children: [
          Container(
            padding: .all(20),
            alignment: .center,
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(30),
              borderRadius: .circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: category.icon,
              fit: BoxFit.cover,
              width: 48,
              height: 48,
              errorWidget: (_, _, _) =>
                  Icon(Icons.error_outline, size: 48, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getTitle(category.title),
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.themeColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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

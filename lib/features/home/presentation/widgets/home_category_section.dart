import 'package:flutter/material.dart';

import '../../../shared/presentation/widget/category_item.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 124,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return CategoryItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 12);
        },
      ),
    );
  }
}

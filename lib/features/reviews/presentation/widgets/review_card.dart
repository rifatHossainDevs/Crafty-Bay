import 'package:flutter/material.dart';

import '../../../../app/assets_paths.dart';
import '../data/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key, required this.reviewModel,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: .circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(AssetsPaths.profilePng),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${reviewModel.user!.firstName} ${reviewModel.user!.lastName}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              reviewModel.comment!,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
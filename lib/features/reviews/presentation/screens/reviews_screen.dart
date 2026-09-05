import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../providers/reviews_list_provider.dart';
import '../widgets/product_reviews_count_cart.dart';
import '../widgets/review_card.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  static const String name = '/reviews-screen';
  final String productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ReviewsListProvider _reviewsListProvider = ReviewsListProvider();

  @override
  void initState() {
    super.initState();
    _reviewsListProvider.refreshReviewList(widget.productId);
    _scrollController.addListener(_loadMore);
  }

  final ScrollController _scrollController = ScrollController();

  void _loadMore() {
    if (_reviewsListProvider.isLoading) return;

    if (_scrollController.position.extentAfter < 300) {
      _reviewsListProvider.getReviews(widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _reviewsListProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reviews"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Consumer<ReviewsListProvider>(
          builder: (context, _, _) {
            if (_reviewsListProvider.initialLoading) {
              return CenteredProgressIndicator();
            }
            return Column(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: RefreshIndicator(
                      onRefresh: () async{
                        _reviewsListProvider.refreshReviewList(widget.productId);
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: _reviewsListProvider.reviews.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(
                            reviewModel: _reviewsListProvider.reviews[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 12);
                        },
                      ),
                    ),
                  ),
                ),
                if (_reviewsListProvider.isLoadingMore)
                  LinearProgressIndicator(),

                ProductReviewsCountCart(
                  reviewsCount: _reviewsListProvider.reviews.length,
                  productId: widget.productId,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}

import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../data/models/review_model.dart';

class ReviewsListProvider extends ChangeNotifier {
  int _pageNo = 0;
  final int _pageSize = 10;
  int? _lastPage;

  bool _initialLoading = false;
  bool get initialLoading => _initialLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  final List<ReviewModel> _reviews = [];
  List<ReviewModel> get reviews => _reviews;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getReviews(String productId) async {
    if (_lastPage != null && _pageNo >= _lastPage!) {
      return;
    }

    _pageNo++;

    if (_isInitialLoading) {
      _initialLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final response = await getNetworkCaller().getRequest(
      Urls.getReviewListUrl(productId, _pageNo, _pageSize),
    );

    if (response.isSuccess) {
      _lastPage ??= response.body['data']['last_page'];

      List<ReviewModel> newReviews = [];
      for (var review in response.body['data']['results']) {
        newReviews.add(ReviewModel.fromJson(review));
      }

      _reviews.addAll(newReviews);
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _initialLoading = false;
    } else {
      _isLoadingMore = false;
    }
    notifyListeners();
  }

  bool get _isInitialLoading => _pageNo == 1;

  bool get isLoading => _initialLoading || _isLoadingMore;

  void refreshReviewList(String productId) {
    _pageNo = 0;
    _lastPage = null;
    _reviews.clear();
    getReviews(productId);
  }
}

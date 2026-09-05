import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_holder_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widget/centered_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widget/product_item.dart';
import 'package:crafty_bay/features/wishlist/presentation/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  static const String name = '/wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final ScrollController _scrolledController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrolledController.addListener(_loadMore);
    });
  }

  void _loadMore() {
    final wishlistProvider = context.read<WishlistProvider>();
    if (wishlistProvider.isLoading) return;

    if (_scrolledController.position.extentAfter < 300) {
      wishlistProvider.getWishListProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WishList"),
        leading: IconButton(
          onPressed: () {
            context.read<MainNavHolderProvider>().backToHome();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<WishlistProvider>(
          builder: (context, wishlistProvider, _) {
            if (wishlistProvider.initialLoading) {
              return const CenteredProgressIndicator();
            }

            if (wishlistProvider.wishListProducts.isEmpty) {
              return const Center(
                child: Text("No Products Found",
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Products: ${wishlistProvider.wishListProducts.length}",
                  style: const TextStyle(fontSize: 16, color: AppColors.themeColor),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      wishlistProvider.refreshWishlistProductList();
                    },
                    child: GridView.builder(
                      controller: _scrolledController,
                      itemCount: wishlistProvider.wishListProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: .7,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItem(
                          productModel:
                              wishlistProvider.wishListProducts[index].product,
                        );
                      },
                    ),
                  ),
                ),
                if (wishlistProvider.isLoadingMore)
                  const LinearProgressIndicator()
              ],
            );
          },
        ),
      ),
    );
  }
}

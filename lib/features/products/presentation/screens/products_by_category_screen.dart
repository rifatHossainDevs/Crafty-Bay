import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/data/models/category_model.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../../../shared/presentation/widget/product_item.dart';
import '../providers/product_by_category_list_provider.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  const ProductsByCategoryScreen({super.key, required this.category});

  static const String name = '/product-by-category';

  final CategoryModel category;

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  final ProductByCategoryListProvider _productByCategoryListProvider =
      ProductByCategoryListProvider();

  final ScrollController _scrolledController = ScrollController();

  @override
  void initState() {
    super.initState();

    _productByCategoryListProvider.getProductByCategoryList(widget.category.id);
    _scrolledController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_productByCategoryListProvider.isLoading) return;

    if (_scrolledController.position.extentAfter < 300) {
      _productByCategoryListProvider
          .getProductByCategoryList(widget.category.id);
    }
  }




  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productByCategoryListProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.title)),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<ProductByCategoryListProvider>(
            builder: (context, _, _) {
              if (_productByCategoryListProvider.initialLoading) {
                return CenteredProgressIndicator();
              }

              if(_productByCategoryListProvider.products.isEmpty){
                return Center(
                  child: Text("No Products Found", style: TextStyle(fontSize: 20, color: Colors.grey)),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _productByCategoryListProvider.refreshProductList(widget.category.id);
                      },
                      child: GridView.builder(
                        controller: _scrolledController,
                        itemCount: _productByCategoryListProvider.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .7,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          return ProductItem(
                            productModel: _productByCategoryListProvider.products[index],
                          );
                        },
                      ),
                    ),
                  ),

                  if (_productByCategoryListProvider.isLoadingMore)
                    LinearProgressIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

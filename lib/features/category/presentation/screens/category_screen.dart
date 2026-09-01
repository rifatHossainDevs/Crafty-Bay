import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_holder_provider.dart';
import '../../../shared/presentation/widget/category_item.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../providers/category_list_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoryListProvider _categoryListProvider;

  @override
  void initState() {
    super.initState();
    _categoryListProvider = context.read<CategoryListProvider>();
    _categoryListProvider.getCategoryList();
    _scrolledController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_categoryListProvider.isLoadingMore == false &&
        _scrolledController.position.extentBefore < 300) {
      _categoryListProvider.getCategoryList();
    }
  }

  final ScrollController _scrolledController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        leading: IconButton(
          onPressed: () {
            context.read<MainNavHolderProvider>().backToHome();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Consumer<CategoryListProvider>(
        builder: (context, categoryListProvider, _) {
          if (categoryListProvider.initialLoading) {
            return CenteredProgressIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    categoryListProvider.refreshCategoryList();
                  },
                  child: GridView.builder(
                    controller: _scrolledController,
                    itemCount: categoryListProvider.categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: CategoryItem(
                          category: categoryListProvider.categories[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (categoryListProvider.isLoadingMore)
                LinearProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}

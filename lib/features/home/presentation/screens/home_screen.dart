import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extension/utility_extension.dart';
import '../../../category/data/models/category_model.dart';
import '../../../products/presentation/providers/home_product_provider.dart';
import '../../../products/presentation/screens/products_by_category_screen.dart';
import '../../../shared/presentation/providers/main_nav_holder_provider.dart';
import '../../../shared/presentation/widget/centered_progress_indicator.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_category_section.dart';
import '../widgets/home_product_section.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_section_header.dart';
import '../widgets/navigation_drawer_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final homeProductProvider = context.watch<HomeProductProvider>();
    return ChangeNotifierProvider.value(
      value: homeProductProvider,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: HomeAppBar(
          onProfileTap: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
        ),
        endDrawer: Drawer(
          child: NavigationDrawerView(localization: localization),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                HomeSearchBar(),
                const SizedBox(height: 12),
                HomeCarouselSlider(),
                const SizedBox(height: 12),
                HomeSectionHeader(
                  title: localization.category,
                  onTapSeeAll: () {
                    context.read<MainNavHolderProvider>().moveToCategory();
                  },
                ),
                HomeCategorySection(),
                const SizedBox(height: 8),
                HomeSectionHeader(
                  title: localization.popular,
                  onTapSeeAll: () {
                    Navigator.pushNamed(
                      context,
                      ProductsByCategoryScreen.name,
                      arguments: CategoryModel(
                        id: '67c35af85e8a445235de197b',
                        title: localization.popular,
                        icon: '',
                      ),
                    );
                  },
                ),
                Consumer<HomeProductProvider>(
                  builder: (context, _, _) {
                    if (homeProductProvider.loading) {
                      return CenteredProgressIndicator();
                    }
                    return HomeProductSection(
                      products: homeProductProvider.popularProducts,
                    );
                  },
                ),
                const SizedBox(height: 8),
                HomeSectionHeader(
                  title: localization.special,
                  onTapSeeAll: () {
                    Navigator.pushNamed(
                      context,
                      ProductsByCategoryScreen.name,
                      arguments: CategoryModel(
                        id: '67c35b395e8a445235de197e',
                        title: localization.special,
                        icon: '',
                      ),
                    );
                  },
                ),
                Consumer<HomeProductProvider>(
                  builder: (context, _, _) {
                    if (homeProductProvider.loading) {
                      return CenteredProgressIndicator();
                    }
                    return HomeProductSection(
                      products: homeProductProvider.popularProducts,
                    );
                  },
                ),
                const SizedBox(height: 8),
                HomeSectionHeader(
                  title: localization.newArrival,
                  onTapSeeAll: () {
                    Navigator.pushNamed(
                      context,
                      ProductsByCategoryScreen.name,
                      arguments: CategoryModel(
                        id: '67c7bec4623a876bc4766fea',
                        title: localization.newArrival,
                        icon: '',
                      ),
                    );
                  },
                ),
                Consumer<HomeProductProvider>(
                  builder: (context, _, _) {
                    if (homeProductProvider.loading) {
                      return CenteredProgressIndicator();
                    }
                    return HomeProductSection(
                      products: homeProductProvider.newProducts,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

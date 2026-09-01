import 'package:crafty_bay/features/category/presentation/providers/category_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extension/utility_extension.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screens.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../../home/presentation/providers/home_sliders_provider.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../products/presentation/providers/home_product_provider.dart';
import '../../../wishlist/presentation/screens/wishlist_screen.dart';
import '../providers/main_nav_holder_provider.dart';

class MainNavHolderScreens extends StatefulWidget {
  const MainNavHolderScreens({super.key});

  static const String name = '/main-nav-holder';

  @override
  State<MainNavHolderScreens> createState() => _MainNavHolderScreensState();
}

class _MainNavHolderScreensState extends State<MainNavHolderScreens> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    WishlistScreen(),
  ];

  DateTime? lastPressed;

  final HomeSlidersProvider _homeSlidersProvider = HomeSlidersProvider();
  final CategoryListProvider _categoryListProvider = CategoryListProvider();
  final HomeProductProvider _homeProductProvider = HomeProductProvider();

  @override
  void initState() {
    super.initState();
    _homeSlidersProvider.getHomeSliders();
    _categoryListProvider.getCategoryList();
    _homeProductProvider.getHomeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _homeSlidersProvider),
        ChangeNotifierProvider.value(value: _categoryListProvider),
        ChangeNotifierProvider.value(value: _homeProductProvider),
      ],
      child: Consumer<MainNavHolderProvider>(
        builder: (context, mainNavHolderProvider, _) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;

              final provider = context.read<MainNavHolderProvider>();

              if (provider.selectedIndex != 0) {
                provider.backToHome();
                return;
              }

              final now = DateTime.now();

              if (lastPressed == null ||
                  now.difference(lastPressed!) > const Duration(seconds: 2)) {
                lastPressed = now;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Press back again to exit")),
                );
              } else {
                SystemNavigator.pop();
              }
            },
            child: Scaffold(
              body: _screens[mainNavHolderProvider.selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: mainNavHolderProvider.selectedIndex,
                onTap: (index) async {
                  if (index == 2 || index == 3) {
                    if (await AuthController.isLoggedIn() == false) {
                      Navigator.pushNamed(context, SignInScreens.name);
                      return;
                    }
                  }

                  mainNavHolderProvider.changeIndex(index);
                },
                selectedItemColor: AppColors.themeColor,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: context.localization.home,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category),
                    label: context.localization.category,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: context.localization.cart,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: context.localization.wishlist,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

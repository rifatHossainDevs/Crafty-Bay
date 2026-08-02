import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../categories/presentation/screens/category_screen.dart';
import '../../../home/presentatin/screens/home_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavHolderProvider>(
      builder: (context, mainNavHolderProvider, _) {
        return Scaffold(
          body: _screens[mainNavHolderProvider.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: mainNavHolderProvider.selectedIndex,
            onTap: mainNavHolderProvider.changeIndex,
            selectedItemColor: AppColors.themeColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Category",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Wishlist",
              ),
            ],
          ),
        );
      },
    );
  }
}

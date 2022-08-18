import 'package:flutter/material.dart';
import 'package:myshop/app/utils/app_colors.dart';
import 'package:myshop/products/screens/categorie_screen.dart';
import 'package:myshop/products/screens/help_screen.dart';
import 'package:myshop/products/screens/product_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  final List<Widget> _screens = const [
    ProductList(),
    CategorieScreen(),
    HelpScreen(),
  ];
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  Widget _currentScreen =const ProductList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: _currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: Container(
          color: AppColors.primary.withOpacity(.1),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _currentScreen = _screens[0];
                    _currentTab = 0;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: _currentTab == 0
                          ? AppColors.primary
                          : Colors.black.withOpacity(.4),
                    ),
                    Text(
                      "Products",
                      style: TextStyle(
                        color: _currentTab == 0
                            ? AppColors.primary
                            : Colors.black.withOpacity(.4),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _currentScreen = _screens[1];
                    _currentTab = 1;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.category,
                      color: _currentTab == 1
                          ? AppColors.primary
                          : Colors.black.withOpacity(.4),
                    ),
                    Text(
                      "Category",
                      style: TextStyle(
                        color: _currentTab == 1
                            ? AppColors.primary
                            : Colors.black.withOpacity(.4),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _currentScreen = _screens[2];
                    _currentTab = 2;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help,
                      color: _currentTab == 2
                          ? AppColors.primary
                          : Colors.black.withOpacity(.4),
                    ),
                    Text(
                      "Help",
                      style: TextStyle(
                        color: _currentTab == 2
                            ? AppColors.primary
                            : Colors.black.withOpacity(.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

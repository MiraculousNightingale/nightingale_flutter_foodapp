import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/widgets/main_drawer.dart';
import '../models/meal.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': const FavouritesScreen(),
        'title': 'Favourites',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> selectedPage = _pages[_selectedPageIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: selectedPage['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.background,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}

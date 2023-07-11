import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/models/category.dart';
import 'package:nightingale_flutter_foodapp/theme_config.dart';

import 'dummy_data.dart';
import 'models/meal.dart';
import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) return false;
        if (_filters['lactose']! && !meal.isLactoseFree) return false;
        if (_filters['vegan']! && !meal.isVegan) return false;
        if (_filters['vegetarian']! && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealId);
    setState(() {
      if (existingIndex >= 0) {
        _favouriteMeals.removeAt(existingIndex);
      } else {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
    });
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeConfig.theme,
      // theme: ThemeData(
      //   primarySwatch: Colors.pink,
      //   canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      //   fontFamily: 'Raleway',
      //   textTheme: ThemeData.light().textTheme.copyWith(
      //         bodyLarge: const TextStyle(
      //           color: Color.fromRGBO(20, 51, 51, 1),
      //         ),
      //         bodyMedium: const TextStyle(
      //           color: Color.fromRGBO(20, 51, 51, 1),
      //         ),
      //         titleLarge: const TextStyle(
      //           fontFamily: 'Raleway',
      //         ),
      //         titleMedium: const TextStyle(
      //           fontSize: 20,
      //           fontFamily: 'RobotoCondensed',
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      // ),
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map;
        final routes = <String, WidgetBuilder>{
          CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
                availableMeals: _availableMeals,
                category: args['category'],
              ),
        };
        if (routes[settings.name] == null) {
          throw 'onGenerateRoute - called with unexisting route name.';
        }
        return MaterialPageRoute(
          builder: (context) => routes[settings.name]!(context),
        );
      },
      routes: {
        '/': (context) => TabsScreen(
              favouriteMeals: _favouriteMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              isFavourite: _isMealFavourite,
              toggleFavourite: _toggleFavourite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Text('Navigation screen'),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

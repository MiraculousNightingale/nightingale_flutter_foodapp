import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/theme_config.dart';

import 'screens/tabs_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeConfig.theme,
      home: const TabsScreen(),
      // TODO: Named routing, remove later.
      // onGenerateRoute: (settings) {
      //   final args = settings.arguments as Map;
      //   final routes = <String, WidgetBuilder>{
      //     CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
      //           availableMeals: _availableMeals,
      //           category: args['category'],
      //         ),
      //   };
      //   if (routes[settings.name] == null) {
      //     throw 'onGenerateRoute - called with unexisting route name.';
      //   }
      //   return MaterialPageRoute(
      //     builder: (context) => routes[settings.name]!(context),
      //   );
      // },
      // routes: {
      //   '/': (context) => TabsScreen(
      //         favouriteMeals: _favouriteMeals,
      //       ),
      //   MealDetailScreen.routeName: (context) => MealDetailScreen(
      //         isFavourite: _isMealFavourite,
      //         toggleFavourite: _toggleFavourite,
      //       ),
      //   FiltersScreen.routeName: (context) => FiltersScreen(
      //         currentFilters: _filters,
      //         saveFilters: _setFilters,
      //       ),
      // },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //     builder: (context) => const CategoriesScreen(),
      //   );
      // },
    );
  }
}

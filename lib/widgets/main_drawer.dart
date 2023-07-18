import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nightingale_flutter_foodapp/screens/meals_screen.dart';
import 'package:nightingale_flutter_foodapp/screens/tabs_screen.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(BuildContext context, String title, IconData icon,
      void Function() onTap) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: theme.textTheme.titleLarge!.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.secondaryContainer.withOpacity(0.75),
                  theme.colorScheme.secondaryContainer.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text('Cooking Up!',
                style: theme.textTheme.headlineLarge!.copyWith(
                  color: theme.colorScheme.onSecondaryContainer,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildListTile(context, 'Main Page', Icons.restaurant, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TabsScreen(),
              ),
            );
          }),
          _buildListTile(context, 'Manage Meals', Icons.manage_search, () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MealsScreen(),
            ));
          }),
          _buildListTile(context, 'Settings', Icons.settings, () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const FiltersScreen(),
            ));
          }),
        ],
      ),
    );
  }
}

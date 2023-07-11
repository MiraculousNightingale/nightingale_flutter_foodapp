import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightingale_flutter_foodapp/models/meal_filter.dart';
import 'package:nightingale_flutter_foodapp/providers/meal_filters_provider.dart';
import 'package:nightingale_flutter_foodapp/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  static const routeName = '/filters';

  final void Function(Map<String, bool> filterData) saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.currentFilters})
      : super(key: key);

  _buildSwitchListTile(
    BuildContext context,
    String title,
    String desc,
    bool currentVal,
    void Function(bool) onChanged,
  ) {
    final theme = Theme.of(context);
    return SwitchListTile(
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
          color: theme.colorScheme.onBackground,
        ),
      ),
      value: currentVal,
      onChanged: onChanged,
      activeColor: theme.colorScheme.tertiary,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(mealFiltersProvider);
    final filterNotifier = ref.read(mealFiltersProvider.notifier);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              print('save is not used with riverpod');
              // final Map<String, bool> selectedFilters = {
              //   'gluten': _glutenFree,
              //   'lactose': _lactoseFree,
              //   'vegan': _vegan,
              //   'vegetarian': _vegetarian,
              // };
              // saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  context,
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  activeFilters[MealFilterType.glutenFree]!.isEnabled,
                  (value) => filterNotifier.setFilter(
                      MealFilterType.glutenFree, value),
                ),
                _buildSwitchListTile(
                  context,
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  activeFilters[MealFilterType.lactoseFree]!.isEnabled,
                  (value) => filterNotifier.setFilter(
                      MealFilterType.lactoseFree, value),
                ),
                _buildSwitchListTile(
                  context,
                  'Vegetarian',
                  'Only include vegetarian-free meals.',
                  activeFilters[MealFilterType.vegetarian]!.isEnabled,
                  (value) => filterNotifier.setFilter(
                      MealFilterType.vegetarian, value),
                ),
                _buildSwitchListTile(
                  context,
                  'Vegan',
                  'Only include vegan-free meals.',
                  activeFilters[MealFilterType.vegan]!.isEnabled,
                  (value) =>
                      filterNotifier.setFilter(MealFilterType.vegan, value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

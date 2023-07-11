// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:nightingale_flutter_foodapp/models/meal.dart';

enum MealFilterType {
  glutenFree,
  vegetarian,
  vegan,
  lactoseFree,
}

@immutable
class MealFilter {
  const MealFilter(this.check, this.isEnabled);
  final bool Function(Meal) check;
  final bool isEnabled;

  MealFilter copyWith({
    bool Function(Meal)? check,
    bool? isEnabled,
  }) {
    return MealFilter(
      check ?? this.check,
      isEnabled ?? this.isEnabled,
    );
  }
}

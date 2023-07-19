// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum Complexity {
  none,
  simple,
  challenging,
  hard,
}

enum Affordability {
  none,
  affordable,
  pricey,
  luxurious,
}

@immutable
class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  Meal.empty()
      : id = '',
        categories = [],
        title = '',
        imageUrl = '',
        ingredients = [],
        steps = [],
        duration = 0,
        complexity = Complexity.none,
        affordability = Affordability.none,
        isGlutenFree = false,
        isLactoseFree = false,
        isVegan = false,
        isVegetarian = false;

  String get capitalizedComplexity =>
      complexity.name.replaceRange(0, 1, complexity.name[0].toUpperCase());

  String get capitalizedAffordability => affordability.name
      .replaceRange(0, 1, affordability.name[0].toUpperCase());

  Meal copyWith({
    String? id,
    List<String>? categories,
    String? title,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? steps,
    int? duration,
    Complexity? complexity,
    Affordability? affordability,
    bool? isGlutenFree,
    bool? isLactoseFree,
    bool? isVegan,
    bool? isVegetarian,
  }) {
    return Meal(
      id: id ?? this.id,
      categories: categories ?? this.categories,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      duration: duration ?? this.duration,
      complexity: complexity ?? this.complexity,
      affordability: affordability ?? this.affordability,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
    );
  }
}

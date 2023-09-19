import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String title;
  final List<String> ingredients;

  Recipe({required this.title, required this.ingredients});

  factory Recipe.fromJson(Map json) => Recipe(
    title: json['title'],
    ingredients: List<String>.from(json['ingredients'] ?? []),
  );

  @override
  List<Object?> get props => [title, ingredients];
}

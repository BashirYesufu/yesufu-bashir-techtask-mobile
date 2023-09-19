import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String title;
  final DateTime useBy;

  Ingredient({required this.title, required this.useBy});

  factory Ingredient.fromJson(Map json) => Ingredient(
    title: json['title'],
    useBy: json['use-by'] == null
        ? DateTime.now()
        : DateTime.parse(json['use-by']),
  );

  @override
  List<Object?> get props => [title, useBy];
}
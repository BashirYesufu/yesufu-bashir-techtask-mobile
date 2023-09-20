import 'package:flutter/material.dart';
import 'package:tech_task/bloc/recipe_bloc.dart';
import 'package:tech_task/widgets/app_scaffold.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({required this.ingredients, Key? key}) : super(key: key);
  final List<String> ingredients;

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  RecipeBloc _recipeBloc = RecipeBloc();

  @override
  void initState() {
    _recipeBloc.fetchRecipes(ingredients: widget.ingredients);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      loadingStream: _recipeBloc.progressObservable,
      appBarTitle: 'Recipes',
    );
  }

}
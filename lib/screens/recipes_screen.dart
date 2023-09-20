import 'package:flutter/material.dart';
import 'package:tech_task/bloc/recipe_bloc.dart';
import 'package:tech_task/constants/color_path.dart';
import 'package:tech_task/widgets/app_scaffold.dart';

import '../models/recipe.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({required this.ingredients, Key? key}) : super(key: key);
  final List<String> ingredients;

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  PageController controller = PageController(viewportFraction: 0.9, keepPage: true);

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
      body: SafeArea(
        child: StreamBuilder(
          stream: _recipeBloc.recipesResponse,
          builder: (context, AsyncSnapshot<List<Recipe>> indexSnapshot) {
            if (indexSnapshot.hasError) {
              return Text(indexSnapshot.error.toString());
            }
            if (indexSnapshot.hasData &&
                indexSnapshot.data?.isNotEmpty == true) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: PageView(
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int page) {},
                  children: List.generate(
                    indexSnapshot.data!.length,
                        (index) => Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 233,
                        decoration: ShapeDecoration(
                          color: ColorPath.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                indexSnapshot.data![index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              );
            }
            if (indexSnapshot.hasData && indexSnapshot.data?.isEmpty == true) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    'Looks like we have no recipes for your selected ingredients',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

import 'package:rxdart/rxdart.dart';
import 'package:tech_task/models/recipe.dart';
import '../api/recipes/recipes_repository_impl.dart';
import 'base_bloc.dart';

class RecipeBloc extends BaseBloc {

  final _repo = RecipesRepositoryImpl();

  final _recipesSubject = PublishSubject<List<Recipe>>();
  Stream<List<Recipe>> get recipesResponse => _recipesSubject.stream;

  void fetchRecipes({required List<String> ingredients}) async {
    if (ingredients.isEmpty){
      _recipesSubject.sink.addError("Kindly select ingredients");
      return;
    }
    try {
      this.triggerProgress(true);
      await _repo.fetchRecipes(ingredients).then((response) {
        _recipesSubject.sink.add(response);
        this.triggerProgress(false);
      }, onError: (e) {
        _recipesSubject.sink.addError(e);
        this.triggerProgress(false);
      });
    } catch (e) {
      _recipesSubject.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _recipesSubject.close();
  }

  @override
  void init() {
    // TODO: implement init
  }

}
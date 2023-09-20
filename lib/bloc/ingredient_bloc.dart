import 'package:rxdart/rxdart.dart';
import 'package:tech_task/api/ingredients/ingredients_repository_impl.dart';
import 'package:tech_task/models/ingredient.dart';
import 'base_bloc.dart';

class IngredientBloc extends BaseBloc {

  final _repo = IngredientsRepositoryImpl();

  final _ingredientsSubject = PublishSubject<List<Ingredient>>();
  Stream<List<Ingredient>> get ingredientsResponse => _ingredientsSubject.stream;

  void fetchIngredients() async {
    try {
      this.triggerProgress(true);
      await _repo.fetchIngredients().then((response) {
        _ingredientsSubject.sink.add(response);
        this.triggerProgress(false);
      }, onError: (e) {
        _ingredientsSubject.sink.addError(e);
        this.triggerProgress(false);
      });
    } catch (e) {
      _ingredientsSubject.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _ingredientsSubject.close();
  }

  @override
  void init() {
    // TODO: implement init
  }

}
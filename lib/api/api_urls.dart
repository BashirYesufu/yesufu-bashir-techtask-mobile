class ApiURLs {

  static const ingredients = "ingredients";
  static recipes(List<String> ingredients) => "recipes?ingredients=${ingredients.join(',')}";

}
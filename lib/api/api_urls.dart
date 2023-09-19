class ApiURLs {

  static const ingredients = "ingredients";
  static recipes(String ingredient) => "recipes?ingredients=$ingredient";

}
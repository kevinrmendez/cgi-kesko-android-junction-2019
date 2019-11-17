class RecipeKesko {
  final String image;
  final String name;
  final String instructions;
  final String ingredients;

  RecipeKesko({
    this.image,
    this.name,
    this.instructions,
    this.ingredients,
  });

  @override
  String toString() {
    print("""
        RECIPE:: title:$name
        """);
    return super.toString();
  }
}

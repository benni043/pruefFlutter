class Recipe {
  final String _name;
  final List<String> _ingredients;
  final List<String> _steps;
  bool _isFavourite;

  Recipe(this._name, this._ingredients, this._steps, this._isFavourite);

  List<String> get steps => _steps;

  List<String> get ingredients => _ingredients;

  String get name => _name;

  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {
    _isFavourite = value;
  }
}
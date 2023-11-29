import 'package:pruef/datatype/Recipe.dart';

class RecipeFav {
  final Recipe _recipe;
  final Function _makeFavourite;

  RecipeFav(this._recipe, this._makeFavourite);

  Function get makeFavourite => _makeFavourite;

  Recipe get recipe => _recipe;
}
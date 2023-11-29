import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruef/datatype/RecipeFav.dart';

import 'datatype/Recipe.dart';

class RecipeWidget extends StatelessWidget {
  Recipe recipe;
  Function makeFavourite;

  RecipeWidget({required this.recipe, required this.makeFavourite, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => {
          Navigator.pushNamed(context, "/full", arguments: RecipeFav(recipe, makeFavourite))
        },
        leading: Image.network("https://cataas.com/cat"),
        title: Text(recipe.name),
        trailing: TextButton(
          onPressed: () => makeFavourite(recipe),
          child: const Icon(Icons.star),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pruef/RecipeWidget.dart';

import 'datatype/Recipe.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Recipe> recipes = [];
List<Recipe> favourites = [];

class _HomeState extends State<Home> {
  bool loading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    final response = await rootBundle.loadString("assets/recepies.json");
    final data = await json.decode(response);

    for (var elem in data) {
      recipes.add(Recipe(elem["name"], List<String>.from(elem["ingredients"]),
          List<String>.from(elem["steps"]), false));
    }

    setState(() {
      loading = false;
    });
  }

  makeFavourite(Recipe recipe) {
    if (recipe.isFavourite) {
      recipe.isFavourite = false;

      setState(() {
        favourites.remove(recipe);
        recipes.add(recipe);
      });
    } else {
      recipe.isFavourite = true;

      setState(() {
        recipes.remove(recipe);
        favourites.add(recipe);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rezepte"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: !loading
          ? Column(
              children: [
                if (favourites.isNotEmpty) const Text("Favouriten", style: TextStyle(fontSize: 26)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var elem in favourites)
                        SizedBox(
                            width: 500,
                            child: RecipeWidget(
                                recipe: elem, makeFavourite: makeFavourite))
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView(
                      children: [
                        for (var elem in recipes)
                          RecipeWidget(
                              recipe: elem, makeFavourite: makeFavourite)
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Text("loading"),
    );
  }
}

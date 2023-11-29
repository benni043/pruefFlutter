import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pruef/datatype/RecipeFav.dart';

import 'datatype/Recipe.dart';

class FullRecipeWidget extends StatefulWidget {
  const FullRecipeWidget({super.key});

  @override
  State<FullRecipeWidget> createState() => _FullRecipeWidgetState();
}

class _FullRecipeWidgetState extends State<FullRecipeWidget> {
  late Recipe recipe;
  late Function makeFavourite;
  bool checking = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        var args = ModalRoute.of(context)!.settings.arguments;

        if (args is RecipeFav) {
          RecipeFav recipeFav =
              ModalRoute.of(context)!.settings.arguments as RecipeFav;

          recipe = recipeFav.recipe;
          makeFavourite = recipeFav.makeFavourite;

          checking = false;
        } else {
          checking = true;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rezept"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
              onPressed: () => makeFavourite(recipe),
              icon: const Icon(Icons.star))
        ],
      ),
      body: !checking
          ? Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Image.network("https://cataas.com/cat"),
                    title: Text(recipe.name),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var elem in recipe.ingredients)
                            SizedBox(
                              width: 300,
                              child: Text(elem),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView(
                      children: [for (var elem in recipe.steps) Text(elem)],
                    ),
                  ),
                )
              ],
            )
          : const Text("Fehler"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';

import '../models/simple_recipe.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({super.key, required this.recipes});

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400),
        // const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeThumbnail(recipe: recipe);
        },
      ),
    );
  }
}

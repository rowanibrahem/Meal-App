import 'package:flutter/material.dart';
import 'package:mealapp/providers/meals_provider.dart';
import 'package:mealapp/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold (
        // appBar: AppBar(
        //   title: const Text(
        //       'Meal App',
        //   ),
        //   centerTitle: true,
        // ),
        body: GridView(
        padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: Provider.of<MealProvider>(context).availableCategory.map((catData)=>
              CategoryItem(
             catData.id,
                // catData.title,
                catData.color,
           ),
          ).toList(),
    ),
      );
  }
}

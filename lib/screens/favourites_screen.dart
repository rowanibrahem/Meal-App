import 'package:flutter/material.dart';
import 'package:mealapp/providers/meals_provider.dart';
import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final List<Meal> favouriteMeal= Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if(favouriteMeal.isEmpty){
      return Center(
        child: Text(lan.getTexts('favorites_text').toString()
        ),
      );
    }
    else {
      return GridView.builder(
        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw<=400 ? 400 : 500,
          childAspectRatio: isLandScape ? dw/(dw*0.8): dw/(dw*0.75),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),

        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeal[index].id,
            imageUrl: favouriteMeal[index].imageUrl,
            // title: favouriteMeal[index].title,
            duration: favouriteMeal[index].duration,
            complexity: favouriteMeal[index].complexity,
            affordability: favouriteMeal[index].affordability,
          );
        },
        itemCount:favouriteMeal.length,
      );
    }
  }
}

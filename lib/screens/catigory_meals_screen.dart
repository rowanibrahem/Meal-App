import 'package:flutter/material.dart';
import 'package:mealapp/widgets/meal_item.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../providers/meals_provider.dart';

class CategoryMealsScreen extends StatefulWidget {

  static const routeName = 'category_meals';

  const CategoryMealsScreen({super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
   String categoryId = '';
  List<Meal> displayedMeals = <Meal>[];
   final _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final List<Meal> availableMeal = Provider
          .of<MealProvider>(context, listen: true)
          .availableMeals;
      final routeArg =
      ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String, String>;
       categoryId = routeArg['id']!;
      // categoryTitle = routeArg['title']!;
      displayedMeals = availableMeal.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
 bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
 var dw = MediaQuery.of(context).size.width;
 var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEng ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
                lan.getTexts('cat-$categoryId').toString(),
            ),
        ),
        body: GridView.builder(
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw<=400 ? 400 : 500,
            childAspectRatio: isLandScape ? dw/(dw*0.8): dw/(dw*0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),

          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              imageUrl: displayedMeals[index].imageUrl,
              // title: displayedMeals[index].title,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}

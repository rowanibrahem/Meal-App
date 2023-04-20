import 'package:flutter/material.dart';
import 'package:mealapp/screens/catigory_meals_screen.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CategoryItem extends StatelessWidget {

   final String id;
  final Color color;

   const CategoryItem(
     this.id,
     this.color, {super.key});
    void selectCategory(BuildContext ctx){
      Navigator.of(ctx).pushNamed(
          CategoryMealsScreen.routeName,
        arguments: {
            'id' : id,
        },
      );
    }
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectCategory(context),
     splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
             color.withOpacity(0.4),
                color,
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

          ),
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child:Text(lan.getTexts('cat-$id').toString(),
            style: Theme.of(context).textTheme.titleSmall
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/language_provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  // final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


  const MealItem({super.key,
    required this.id,
    required this.imageUrl,
    // required this.title,
    required this.duration,
    required this.complexity,
    required this.affordability,

  });

  // Object? get complexityText {
  //   var lan = Provider.of<LanguageProvider>(context, listen: true);
  //   switch (complexity) {
  //     case Complexity.simple:
        // return lan.getTexts('Complexity.Simple' );
  //       break;
  //     case Complexity.hard:
  //       return 'Hard';
  //       break;
  //     case Complexity.challenging:
  //       return 'Challenging';
  //       break;
  //     default:
  //       return 'Unknown';
  //       break;
  //   }
  // }

  // String get affordabilityText {
  //   switch (affordability) {
  //     case Affordability.affordable:
  //       return 'Affordable';
  //       break;
  //     case Affordability.pricey:
  //       return 'Pricey';
  //       break;
  //     case Affordability.luxurious:
  //       return 'Luxurious';
  //       break;
  //     default:
  //       return 'Unknown';
  //       break;
  //   }
  // }

  // ctrl+alt+l to format code
  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName,
        arguments: id
    ).then((result) {
      // if (result != null) removeItem(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          width: double.infinity,
                          image: NetworkImage(
                            imageUrl,
                          ),
                          placeholder: AssetImage('assets/images/a2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        lan.getTexts("meal-$id").toString(),
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                         Icon(Icons.schedule ,color: Theme.of(context).buttonColor,),
                        const SizedBox(
                          width: 6,
                        ),
                        if (duration <= 10)
                          Text("$duration " + lan.getTexts("min2").toString()),
                        if (duration > 10)
                          Text("$duration " + lan.getTexts("min").toString()),
                      ],
                    ),
                    Row(
                      children: [
                         Icon(Icons.work , color: Theme.of(context).buttonColor,),
                        const SizedBox(
                          width: 6,
                        ),
                        // if(lan.isEng==true)
                        // Text(
                        //   // "$complexity",),
                        //   // lan.textsAr['co'];
                        //  lan.getTexts('$complexity').toString(),
                        // )
                        Text(lan.getTexts("$complexity").toString()),
                      ],
                    ),
                    Row(
                      children: [
                         Icon(Icons.attach_money , color: Theme.of(context).buttonColor,),
                        const SizedBox(width: 6),
                        Text(lan.getTexts('$affordability').toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

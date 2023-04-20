import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/meals_provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = 'meal_detail';

  const MealDetailScreen({super.key});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall , textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(Widget child , BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: isLandScape? dh * 0.5 : dh * 0.25,
      width: isLandScape? (dw * .5-30): dw,
      child: child,
    );
  }

  String mealId = '';

  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).colorScheme.secondary;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List<String> stepsLi = lan.getTexts('steps-$mealId') as List<String>;
    var liSteps = ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) =>
          Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: Text(
                    "# ${index+1}",
                  ),
                ) ,
                title: Text(
                  stepsLi[index],
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
      itemCount: stepsLi.length,
    );
    List<String> liIngredientLi = lan.getTexts('ingredients-$mealId') as List<String>;
    var liIng = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            liIngredientLi[index],
            style: TextStyle(
              color: useWhiteForeground(accentColor)? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      itemCount: liIngredientLi.length,
    );
    return Directionality(
      textDirection: lan.isEng ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId').toString()),
                background: Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      image: NetworkImage(
                        selectMeal.imageUrl,
                      ),
                      placeholder: const AssetImage('assets/images/a2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              if(isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Ingredients').toString()),
                        buildContainer(liIng , context),
                      ],
                    ),
                    Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Steps').toString()),
                        buildContainer(liSteps , context),
                      ],
                    ),
                  ],
                ),
              if(!isLandScape) buildSectionTitle(context, lan.getTexts('Ingredients').toString()),
              if(!isLandScape) buildContainer(liIng , context),
              if(!isLandScape) buildSectionTitle(context, lan.getTexts('Steps').toString()),
              if(!isLandScape) buildContainer(liSteps , context),
              // SizedBox(height: 700,),
            ])),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false).toggleFavourite(mealId),
          child: Icon(
              Provider.of<MealProvider>(context, listen: true).isMealFavourite(mealId) ? Icons.star : Icons.star_border,
          ),
        ),
      ),
    );
  }
}

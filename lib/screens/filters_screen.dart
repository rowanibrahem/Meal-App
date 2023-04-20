import 'package:flutter/material.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meals_provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final bool fromOnBoarding;

  FiltersScreen({super.key, this.fromOnBoarding = false});


  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // bool _GlutenFree = false;
  // bool _LactoseFree = false;
  // bool _Vegan = false;
  // bool _Vegetarian = false;

 // @override
 //  void initState() {
 //   final Map<String , bool> currentFilters = Provider.of<MealProvider>(context, listen: false).filters;
 //   _GlutenFree = currentFilters['gluten']!;
 //   _LactoseFree = currentFilters['lactose']!;
 //   _Vegan = currentFilters['vegan']!;
 //    _Vegetarian = currentFilters['vegetarian']!;
 //    super.initState();
 //  }

  Widget builtList(String text, String subText, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(text),
      subtitle: Text(subText),
      value: currentValue,
      onChanged: updateValue,
      inactiveTrackColor:
      Provider.of<ThemeProvider>(context , listen: true).tm ==
          ThemeMode.light
          ?null :
         Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String , bool> currentFilters = Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEng ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.save),
          //     onPressed: (){
          //       final  selectedFilters = {
          //         'gluten': _GlutenFree,
          //         'lactose': _LactoseFree,
          //         'vegan': _Vegan,
          //         'vegetarian': _Vegetarian,
          //       };
          //       Provider.of<MealProvider>(context, listen: false).setFilters(selectedFilters);
          //     },
          //
          //   ),
          // ],

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: widget.fromOnBoarding ? null : Text(lan.getTexts('filters_appBar_title').toString()),
              backgroundColor: widget.fromOnBoarding ? Theme.of(context).canvasColor : Theme.of(context).primaryColor ,
              elevation: widget.fromOnBoarding ? 0 : 5,
            ),
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  lan.getTexts('filters_screen_title').toString(),
                  style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,
                ),
              ),
              builtList(
                lan.getTexts('Gluten-free').toString(),
                lan.getTexts('Gluten-free-sub').toString(),
                currentFilters['gluten']!,
                    (newValue) {
                  setState(() {
                    currentFilters['gluten'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false).setFilters();
                },
              ),
              builtList(
                lan.getTexts('Lactose-free').toString(),
                lan.getTexts('Lactose-free_sub').toString(),
                currentFilters['lactose']!,
                    (newValue) {
                  setState(() {
                    currentFilters['lactose'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false).setFilters();
                },
              ),
              builtList(
                lan.getTexts('Vegan').toString(),
                lan.getTexts('Vegan-sub').toString(),
                currentFilters['vegan']!,
                    (newValue) {
                  setState(() {
                    currentFilters['vegan'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false).setFilters();
                },
              ),
              builtList(
                lan.getTexts('Vegetarian').toString(),
                lan.getTexts('Vegetarian-sub').toString(),
                currentFilters['vegetarian']!,
                    (newValue) {
                  setState(() {
                    currentFilters['vegetarian'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false).setFilters();
                },
              ),
              SizedBox(height: widget.fromOnBoarding ? 80 :0),
            ]),
            ),
          ],
        ),
        drawer:  widget.fromOnBoarding ? null :MainDrawer(),

      ),
    );
  }
}

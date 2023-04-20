import 'package:flutter/material.dart';
import 'package:mealapp/providers/meals_provider.dart';
import 'package:mealapp/screens/categories_screen.dart';
import 'package:mealapp/screens/favourites_screen.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs_screen';
  const TabsScreen({super.key});


  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
    List<Map<String , Object>> _pages = [] ;

  int  _selectedPageIndex = 0 ;

  @override
  void initState() {
    Provider.of<MealProvider>(context,listen: false).setData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getThemeColors();
    Provider.of<LanguageProvider>(context,listen: false).getLan();
    super.initState();
  }

 void _selectpage(int value) {
   setState(() {
     _selectedPageIndex = value;
   });


  }
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {
        'page' : const CategoriesScreen(),
        'title': lan.getTexts('categories').toString(),
      },
      {
        'page' : const FavouritesScreen(),
        'title' :  lan.getTexts('your_favorites').toString(),
      },
    ];
    return Directionality(
      textDirection: lan.isEng ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _pages[_selectedPageIndex]['title'].toString()),
        ),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectpage,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items:  [
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: lan.getTexts('categories').toString(),
              ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: lan.getTexts('your_favorites').toString(),
            ),
          ],

        ),
        drawer: const MainDrawer(),
      ),
    );
  }
}


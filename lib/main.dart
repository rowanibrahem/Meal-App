import 'package:flutter/material.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/meals_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/catigory_meals_screen.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:mealapp/screens/on_boarding_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = (prefs.getBool('watched') ?? false) ? const TabsScreen() : const OnBoardingScreen();
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  // to remove everything when i start the app
  runApp(
    MultiProvider(
        providers: [
    ChangeNotifierProvider<MealProvider>(
    create: (ctx) => MealProvider(),
    ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (ctx) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (ctx) => LanguageProvider(),
          ),
        ],
        child: MyApp(homeScreen),
  ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  MyApp(this.mainScreen);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
        canvasColor: const Color.fromRGBO(255, 254,229, 1),
        fontFamily: 'Raleway',
        buttonColor: Colors.black87,
        cardColor:Colors.white,
        shadowColor: Colors.white60,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          titleSmall: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: accentColor),
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
         fontFamily: 'Raleway',
        buttonColor: Colors.white70,
        cardColor:const Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyMedium: const TextStyle(
                color: Colors.white70,
              ),
              titleSmall: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        '/': (context) => mainScreen,
       TabsScreen.routeName: (ctx) =>  const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemeScreen.routeName: (context) => const ThemeScreen(),
      },
    );
  }
}

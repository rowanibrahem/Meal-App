import 'package:flutter/material.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../screens/theme_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String text , IconData icon , Function() tap , BuildContext ctx){
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        text,
        style:  TextStyle(
          color: Theme.of(ctx).textTheme.bodyMedium?.color,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
        ),
      ),
      onTap: tap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEng ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.all(20),
              alignment: lan.isEng
              ? Alignment.centerLeft
              : Alignment.centerRight,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                lan.getTexts('drawer_name').toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildListTile(
                lan.getTexts('drawer_item1').toString(),
              Icons.restaurant,
                (){
                Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
                }, context),
            buildListTile(
                lan.getTexts('drawer_item2').toString(),
              Icons.settings,
                (){
                  Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
                }, context
            ),
            buildListTile(
                lan.getTexts('drawer_item3').toString(),
                Icons.color_lens,
                    (){
                  Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
                }, context),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
            const SizedBox(height: 10,),
            Text(
              lan.getTexts('drawer_switch_title').toString(),
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(lan.getTexts('drawer_switch_item2').toString(),
            style: Theme.of(context).textTheme.titleSmall,
              ),
            Switch(
                value: lan.isEng,
                onChanged: (newValue) {
                  lan.changeLan(newValue);
                  Navigator.of(context).pop();
                },
              inactiveTrackColor: Provider.of<ThemeProvider>(context , listen: true).tm ==
                  ThemeMode.light
                  ? null
                  : Colors.black,
            ),
                Text(lan.getTexts('drawer_switch_item1').toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

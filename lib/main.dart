import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screeen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Map<String,bool> _filters={
  'gluten': false,
  'lactose': false,
  'vegan': false,
  'vegetarian': false
};

List<Meal> _availableMeals= DUMMY_MEALS;
List<Meal> _favoriteMeals=[];
void _setFilters(Map<String,bool> filterdata){
setState(() {
  _filters=filterdata;
  _availableMeals=DUMMY_MEALS.where((meal){
    if(_filters['gluten']&& !meal.isGlutenFree)
    return false;
     if(_filters['lactose']&& !meal.isLactoseFree)
    return false;
     if(_filters['vegan']&& !meal.isVegan)
    return false;
     if(_filters['vegetarian']&& !meal.isVegetarian)
    return false;
    return true;
  }
  ).toList();
});

}
void _toggleFavorite(String mealId){
final existingMeal=_favoriteMeals.indexWhere((meal)=>mealId==meal.id);
if(existingMeal>=0){
  setState(() {
    _favoriteMeals.removeAt(existingMeal);
  });
}else{
  setState(() {
    _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal)=>meal.id==mealId));
  });
}

}

bool  isMealFavorite(String id){
 return _favoriteMeals.any((meal)=>meal.id==id);
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 253, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1:TextStyle(color: Color.fromRGBO(20, 51, 51, 1)) ,
          body2:TextStyle(color: Color.fromRGBO(20, 51, 51, 1)) ,
          title: TextStyle(fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,)
          

        )
      ),
     // home: CategoriesScreen,
      initialRoute: '/',
      routes: {
        '/': (ctx)=>TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routname: (context)=>CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName:(context)=>MealDetailScreen(_toggleFavorite,isMealFavorite),
        FiltersScreen.routName:(context)=>FiltersScreen(_filters,_setFilters),
        

      },
      //onUnknownRoute: (settings){
        //return MaterialPageRoute(builder: (context)=>CategoryMealsScreen(_availableMeals));
      //},

    );
  }
}


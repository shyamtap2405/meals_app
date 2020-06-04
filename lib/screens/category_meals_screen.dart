import 'package:flutter/material.dart';

import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routname='/categories-meals';
   final List<Meal> availableMeals;

  const CategoryMealsScreen( this.availableMeals) ;
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
String categoryTitle;
List<Meal> displayedMeals;
var loadedInitData=false;
 @override
  void initState() {
    
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!loadedInitData){
    final routArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final categoryId= routArgs['id'];
     categoryTitle= routArgs['title'];
    displayedMeals=widget.availableMeals.where((meal){
      return meal.categories.contains(categoryId);
    }).toList();
    loadedInitData=true;
    }
    
    super.didChangeDependencies();
  }

 //void _removeMeal(String mealId){
   //setState(() {
     //displayedMeals.removeWhere((meal)=>meal.id==mealId);
  // });
     
// }
 
  @override
  Widget build(BuildContext context) {
    


    return Scaffold(appBar: AppBar(title: Text(categoryTitle)),
      body:ListView.builder(itemBuilder: (context,index){
        return MealItem(id: displayedMeals[index].id,title: displayedMeals[index].title,
         imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          
           complexity: displayedMeals[index].complexity, affordability: displayedMeals[index].affordability);
      },
      itemCount: displayedMeals.length,
      )
    );
  }
}
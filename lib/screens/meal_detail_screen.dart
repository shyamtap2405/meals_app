import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFovorites;
  final Function isMealFavorite;
  MealDetailScreen(this.toggleFovorites,this.isMealFavorite);
  static const routeName='/meal-detail';
   Widget buildSectionTitle(String text,BuildContext context){
      return Container(margin: EdgeInsets.symmetric(vertical:10),
        child: Text(text,style: Theme.of(context).textTheme.title,),);
    }
    Widget buildContainer(Widget child){
       return Container(height: 200,
        decoration: BoxDecoration(color: Colors.white,border: Border.all(color:Colors.grey),
        borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: 300,
        child:child);
    }
  @override
  Widget build(BuildContext context) {
    final mealId=ModalRoute.of(context).settings.arguments as String ;
    final selectedMeal=DUMMY_MEALS.firstWhere((meal)=>meal.id==mealId);

   
    return Scaffold(appBar: AppBar(title: Text('${selectedMeal.title}'),),
      body:
    SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(height: 300,
        width: double.infinity,
        child: Image.network(selectedMeal.imageUrl,
        fit: BoxFit.cover,
        ),
        ),
        buildSectionTitle('Ingredients', context),
          
          
          buildContainer(ListView.builder(itemBuilder: (ctx,index){
            return  Card(child: Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),child: Text(selectedMeal.ingredients[index])),
            color: Theme.of(context).accentColor,) ;
          },
          itemCount: selectedMeal.ingredients.length,
          ),
          ),
          buildSectionTitle("Steps", context),
          buildContainer(ListView.builder(itemBuilder: (ctx,index)=>Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(child: Text('# ${index+1}'),),
                title: Text(selectedMeal.steps[index]),
              ),
              Divider()
            ],
          ),
          itemCount: selectedMeal.steps.length,
          )
          ),


      ],),
    ),
    floatingActionButton: FloatingActionButton(child: Icon(isMealFavorite(mealId)? Icons.favorite:Icons.favorite_border),
    onPressed:()=>toggleFovorites(mealId),
    ),
      
    );
  }
}
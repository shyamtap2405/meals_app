import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
static const routName='/FilterScreen';
final Function setFilters;
final Map<String,bool> filters;

  const FiltersScreen( this.filters,this.setFilters) ;

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenfree=false;
  bool _lactosefree=false;
  bool _vegan=false;
  bool _vegetarian=false;
  
  

  

  Widget buildSwitchTile(bool  currentValue,String text, Function updateValue){
    return  SwitchListTile(value: currentValue, onChanged: updateValue, 
         title: Text(text),
         subtitle: Text('Only include $text meals'),);
  }
  
  @override
  void initState() {
   _glutenfree=widget.filters['gluten'];
   _lactosefree=widget.filters['lactose'];
   _vegan=widget.filters['vegan'];
   _vegetarian=widget.filters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar
      (title: Text('Filters'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save),
         onPressed: (){
           final selectedFilters={
              'gluten':_glutenfree,
              'lactose':_lactosefree,
              'vegan':_vegan,
              'vegetarian':_vegetarian
           };
           widget.setFilters(selectedFilters);},
         ),
      ],
      ),
      drawer: MainDrawer(),
      body: Column(children: <Widget>[
        Container(child: Text('Adjust your Meals Selection',
        style: Theme.of(context).textTheme.title,
        ),
        
        
        padding: EdgeInsets.all(20),),
        Expanded(child: ListView(children: <Widget>[
        buildSwitchTile(_glutenfree, 'Gluten Free', (newValue){
          setState(() {
            _glutenfree=newValue;
          });
        }),
        buildSwitchTile(_vegetarian, 'Vegetarian',
        (newValue){
          setState(() {
            _vegetarian=newValue;
          });}),
        buildSwitchTile(_vegan, 'Vegan',(newValue){
          setState(() {
            _vegan=newValue;
          });}),
        buildSwitchTile(_lactosefree, 'Lactose free',(newValue){
          setState(() {
            _lactosefree=newValue;
          });})

        ],),)
      ],),
     );
  }
}
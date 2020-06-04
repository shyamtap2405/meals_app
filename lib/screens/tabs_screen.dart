import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
  final List<Meal> favorites;
  TabsScreen(this.favorites);

}

class _TabsScreenState extends State<TabsScreen> {
  
 List<Map<String,Object>> _page;



 int _selectedIndex=0;
void _selectedPage(int index){
  setState(() {
    _selectedIndex=index;
  });
  
}
@override
  void initState() {
    _page=[
  {
    'page':CategoriesScreen(),'title':'Categories'

  },
  {'page':FavoritesScreen(widget.favorites),'title':'Favorites'}
  
];
    
    super.initState();
  }
  @override   
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,child: Scaffold(
      appBar: AppBar(title: Text(_page[_selectedIndex]['title']),
     ),
     drawer: MainDrawer(),
      body: _page[_selectedIndex]['page'],
      bottomNavigationBar:
       BottomNavigationBar(onTap: _selectedPage,
         backgroundColor: Theme.of(context).primaryColor,
         unselectedItemColor: Colors.white,
         selectedItemColor: Theme.of(context).accentColor,
         currentIndex: _selectedIndex,
         type: BottomNavigationBarType.shifting,
             

      items: [BottomNavigationBarItem(
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.category),
        title: Text('Category'),
      ),
      BottomNavigationBarItem(
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.star),title:Text('Favorites') ,
      ),
      
      ],
      ),

    ),
      
    );
  }
}
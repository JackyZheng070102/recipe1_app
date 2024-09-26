import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

// HomeScreen: Displays the list of recipes
class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> recipes = [
    {'name': 'Spaghetti', 'ingredients': 'Pasta, Tomato Sauce', 'instructions': 'Boil pasta, add sauce'},
    {'name': 'Grilled Cheese', 'ingredients': 'Bread, Cheese, Butter', 'instructions': 'Butter bread, grill with cheese'},
    {'name': 'Salad', 'ingredients': 'Lettuce, Tomato, Cucumber', 'instructions': 'Chop vegetables, mix together'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index]['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipe: recipes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// DetailsScreen: Displays details of the selected recipe
class DetailsScreen extends StatefulWidget {
  final Map<String, String> recipe;

  DetailsScreen({required this.recipe});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        FavoritesScreen.favoriteRecipes.add(widget.recipe);
      } else {
        FavoritesScreen.favoriteRecipes.remove(widget.recipe);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients: ${widget.recipe['ingredients']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Instructions: ${widget.recipe['instructions']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: toggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              label: Text(isFavorite ? 'Unfavorite' : 'Favorite'),
            ),
          ],
        ),
      ),
    );
  }
}

// FavoritesScreen: Displays only the favorite recipes
class FavoritesScreen extends StatelessWidget {
  static List<Map<String, String>> favoriteRecipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteRecipes[index]['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipe: favoriteRecipes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

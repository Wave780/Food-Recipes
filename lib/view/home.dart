import 'package:api_test/model/users_model.dart';
import 'package:api_test/services/services.dart';
import 'package:api_test/view/widget/card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.restaurant_menu_sharp,
            color: Colors.amberAccent,
            size: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Food Recipes',
            style: TextStyle(fontSize: 30, color: Colors.amberAccent),
          )
        ],
      )),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (BuildContext context, int index) {
                return RecipeCard(
                    title: recipes[index].name,
                    cookTime: recipes[index].totalTime,
                    rating: recipes[index].rating.toString(),
                    thumbnailUrl: recipes[index].image);
              },
            ),
    );
  }
}

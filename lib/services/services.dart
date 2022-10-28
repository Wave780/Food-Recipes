import 'dart:convert';
import 'package:api_test/model/users_model.dart';
import 'package:http/http.dart' as http;

class RecipeApi {

  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "20", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "eea70c6967msh39c45c197e30b3fp1fe57ejsn21684c1090db",
      "X-RapidAPI-Host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });
    Map data = jsonDecode(response.body);
    List temp = [];

    for (var i in data['feed']) {
      temp.add(i['content']['details']);
    }

    return Recipe.recipeFromSnapshot(temp);
  }
}

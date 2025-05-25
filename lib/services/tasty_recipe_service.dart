import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tasty_recipe_model.dart';

class TastyRecipeService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api/FoodRapidApi';

  static Future<List<TastyRecipeModel>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((json) => TastyRecipeModel.fromJson(json)).toList();
      } else {
        throw Exception('Tarif verileri alınamadı. Durum kodu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Tarif verileri alınırken hata oluştu: $e');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/basket_model.dart';

class BasketService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api';

  static Future<List<BasketModel>> getBasketsByTable(int menuTableID) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/Basket/BasketListByMenuTableWithProductName?id=$menuTableID'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => BasketModel.fromJson(item)).toList();
    } else {
      throw Exception('Sepet verileri alınamadı.');
    }
  }

  static Future<bool> addToBasket({
    required int menuTableID,
    required int productID,
    required int count,
    required double price,
  }) async {
    final url = Uri.parse('$_baseUrl/Basket');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'menuTableID': menuTableID,
        'productID': productID,
        'count': count,
        'totalPrice': double.parse((price * count).toStringAsFixed(2)),
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<void> deleteFromBasket(int basketID) async {
    final url = Uri.parse('$_baseUrl/Basket/$basketID');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Ürün silinemedi.');
    }
  }


  }


import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api/Chat';

  // Kalori Bilgisi Al
  static Future<String> ask(String message) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/Ask'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message), // doğru: sadece string json encode ediliyor
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Cevap alınamadı: ${response.statusCode}');
    }
  }

  // İçindekiler Bilgisi Al
  static Future<String> ingredients(String foodName) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/Ingredients'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(foodName), // içerik de JSON string formatında
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('İçindekiler alınamadı: ${response.statusCode}');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message_model.dart';

class MessageService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api';

  static Future<bool> sendMessage(MessageModel message) async {
    final url = Uri.parse('http://10.0.2.2:5044/api/Message'); // API doğru mu?
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message.toJson()),
      );
      print('API cevabı: ${response.statusCode} ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('API hatası: $e');
      return false;
    }
  }


}

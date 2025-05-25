import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/footer_model.dart';

class FooterService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api/';

  static Future<FooterModel?> getFooter() async {
    final url = Uri.parse('http://10.0.2.2:5044/api/Contact');

    try {
      final response = await http.get(url, headers: {'Accept': 'application/json'});

      print('Footer API cevabı: ${response.statusCode}');
      print('Footer body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          return FooterModel.fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      print('Footer verisi alınamadı: $e');
      return null;
    }
  }
}

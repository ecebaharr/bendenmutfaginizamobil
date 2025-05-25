import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_table_model.dart';

class MenuTableService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api';

  static Future<List<MenuTableModel>> getTables() async {
    final response = await http.get(Uri.parse('$_baseUrl/MenuTables'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => MenuTableModel.fromJson(item)).toList();
    } else {
      throw Exception('Masa listesi alınamadı.');
    }
  }

  /// 🔥 MASAYI DOLU YAP
  static Future<void> changeTableStatusToTrue(int masaID) async {
    final url = Uri.parse('$_baseUrl/MenuTables/ChangeMenuTableStatusToTrue?id=$masaID');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Masa durumu güncellenemedi.');
      }
    } catch (e) {
      print('❌ Masa güncelleme hatası: $e');
    }
  }
}

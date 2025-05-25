import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking_model.dart';

class BookingService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api/Booking';

  static Future<bool> sendBooking(BookingModel booking) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(booking.toJson()),
      );

      print("🎯 Booking POST gönderildi:");
      print("Body: ${jsonEncode(booking.toJson())}");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("🚨 Hata: $e");
      return false;
    }
  }
}

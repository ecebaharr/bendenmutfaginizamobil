import 'dart:convert';

import 'package:http/http.dart' as http;import '../models/discount_model.dart';


import '../models/product_model.dart';
import '../models/slider_model.dart';
import '../models/testimonial_model.dart';
import '../models/category_model.dart';


class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:5044/api';

  static Future<List<SliderModel>> getSliders() async {
    final response = await http.get(Uri.parse('$_baseUrl/Slider'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => SliderModel.fromJson(item)).toList();
    } else {
      throw Exception('Slider verileri alınamadı.');
    }
  }
  static Future<List<DiscountModel>> getDiscounts() async {
    final response = await http.get(Uri.parse('$_baseUrl/Discount'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<DiscountModel> discounts = data.map((item) => DiscountModel.fromJson(item)).toList();
      return discounts;
    } else {
      throw Exception('İndirim verileri alınamadı.');
    }
  }
  static Future<List<ProductModel>> getLast9Products() async {
    final response = await http.get(Uri.parse('$_baseUrl/Product/GetLast9Products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Ürün verileri alınamadı.');
    }
  }
  static Future<List<TestimonialModel>> getTestimonials() async {
    final response = await http.get(Uri.parse('$_baseUrl/Testimonial'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => TestimonialModel.fromJson(item)).toList();
    } else {
      throw Exception('Yorumlar alınamadı.');
    }
  }
  static Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/Category'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => CategoryModel.fromJson(item)).toList();
    } else {
      throw Exception('Kategori verileri alınamadı.');
    }
  }





}





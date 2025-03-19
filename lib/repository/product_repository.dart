import 'dart:convert';
import 'package:flutter_mid/model/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final String apiUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to API: ${e.toString()}');
    }
  }
}

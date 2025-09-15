import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_stateful/Homework07/Product.dart';

// final String url = "172.20.10.9";
final String url = "127.0.0.1";

Future<List<Product>> getProducts() async {
  // Use your local IP address, not 'localhost', for a mobile app
  final uri = Uri.parse('http://$url:3000/api/products');
  // final uri = Uri.parse('http://127.0.0.1:3000/api/products');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // The API call was successful
      final List<dynamic> productsJson = jsonDecode(response.body);
      final List<Product> products = productsJson
          .map((json) => Product.fromMap(json))
          .toList();
      print('Users fetched successfully: $products');
      return products;

      // You can now use this 'users' list to build your UI
    } else {
      // The API call failed
      throw Exception("Error while reading: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("An Error occurred: $e ");
  }
}

insertProducts(Product product) {}
updateProducts(Product product) {}
deleteProducts(String pid) {}

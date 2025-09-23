import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_stateful/Homework07/Product.dart';

// final String url = "172.20.10.9";
final String url = "127.0.0.1";

Future<List<Product>> getProducts() async {
  final uri = Uri.parse('http://$url:3000/api/products/');
  // final uri = Uri.parse('http://127.0.0.1:3000/api/products');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // Decode the JSON array from the response body
      final List<dynamic> productsJson = jsonDecode(response.body);
      // Map each JSON object in the array to a Product object
      final List<Product> products = productsJson
          .map((json) => Product.fromMap(json))
          .toList();
      return products;
    } else {
      throw Exception("Error while reading: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("An Error occurred: $e ");
  }
}

// Get single product
Future<Product> getProduct(int pid) async {
  final uri = Uri.parse('http://$url:3000/api/products/$pid');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> productJson = jsonDecode(response.body);
      return Product.fromMap(productJson);
    } else {
      throw Exception("Error while reading product: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("An Error occurred: $e ");
  }
}

Future<String> insertProducts(Product product) async {
  final uri = Uri.parse('http://$url:3000/api/products/');
  final body = json.encode(product.toCreateMap());
  // String url = "http://192.168.1.98/api4fllutter/write.php";
  final response = await http.post(
    uri,
    body: body,
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 201) {
    return response.body;
  } else {}
  throw Exception("Error while writing: ${response.statusCode}");
}

Future<String> updateProducts(Product product) async {
  final uri = Uri.parse('http://$url:3000/api/products/${product.pid}');
  final body = json.encode(product.toUpdateMap());
  http.Response response = await http.patch(
    uri,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(
      "Error while updating: ${response.statusCode}, Body: ${response.body}",
    );
  }
}

Future<void> deleteProducts(int pid) async {
  final uri = Uri.parse('http://$url:3000/api/products/$pid');
  final response = await http.delete(
    uri,
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to delete product');
  }
}

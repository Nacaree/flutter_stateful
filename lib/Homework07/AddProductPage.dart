import 'dart:core';

import 'package:flutter/material.dart';
import 'package:learn_stateful/Homework07/Product.dart';
import 'package:learn_stateful/Homework07/ProductService.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _addProduct() async {
    if (_nameCtrl.text.isEmpty || _priceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("name and price cannot be empty.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      Product product = Product(
        name: _nameCtrl.text,
        price: double.tryParse(_priceCtrl.text),
        description: _descCtrl.text,
      );
      final result = await insertProducts(product);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product added: $result")));
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to add product: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color.fromARGB(255, 197, 37, 181),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Color.fromARGB(255, 197, 37, 181),
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: 'Name',
                floatingLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 197, 37, 181),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              cursorColor: Color.fromARGB(255, 197, 37, 181),
              controller: _priceCtrl,
              decoration: InputDecoration(
                labelText: 'Price',
                floatingLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 197, 37, 181),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descCtrl,
              cursorColor: Color.fromARGB(255, 197, 37, 181),
              decoration: InputDecoration(
                labelText: 'Description',
                floatingLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 197, 37, 181),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 197, 37, 181),
                  ),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32.0),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addProduct,
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 197, 37, 181),
                      ),
                    ),
                    child: const Text('Add Product'),
                  ),
          ],
        ),
      ),
    );
  }
}

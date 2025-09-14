import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
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
            ElevatedButton(
              onPressed: () {
                // Add your logic to save the product here
              },
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

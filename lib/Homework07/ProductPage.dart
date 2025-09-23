import 'package:flutter/material.dart';
import 'package:learn_stateful/Homework07/AddProductPage.dart';
import 'package:learn_stateful/Homework07/Product.dart';
import 'package:learn_stateful/Homework07/ProductDetailPage.dart';
import 'package:learn_stateful/Homework07/ProductService.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> products;
  @override
  void initState() {
    super.initState();
    products = getProducts();
  }

  void _refreshProducts() {
    setState(() {
      products = getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color.fromARGB(255, 8, 113, 199),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return _productBuilder(snapshot.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 8, 113, 199),
        foregroundColor: Colors.white,
        splashColor: Colors.red,
        shape: const CircleBorder(),
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
          if (added == true) {
            _refreshProducts();
          }
        },
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
    );
  }

  // * Better way of doing it
  Widget _productBuilder(List<Product> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95, // * change size of the box
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return InkWell(
          onTap: () async {
            final updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
            if (updated == true) {
              _refreshProducts();
            }
          },
          child: Card(
            elevation: 5, // shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    child: Expanded(
                      // color: Colors.amber,
                      child: Image.network(
                        // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                        "https://i.pinimg.com/originals/08/43/13/0843134f41cc7e423d9d3a08edb7afd0.jpg?nii=t",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name ?? ""),
                      Text("Price: ${product.price}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget _productBuilder() {
//   return GridView.builder(
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 1,
//     ),
//     itemCount: 5,
//     itemBuilder: (BuildContext context, int index) {
//       return Container(
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Expanded(child: Container(color: Colors.amber)),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("He'd you all unravel at the"),
//                 Text("Price: 20"),
//               ],
//             ),
//             SizedBox(height: 24),
//           ],
//         ),
//       );
//     },
//   );
// }

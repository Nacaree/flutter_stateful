import 'package:flutter/material.dart';
import 'package:learn_stateful/Homework07/AddProductPage.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
      body: _productBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 8, 113, 199),
        foregroundColor: Colors.white,
        splashColor: Colors.red,
        shape: CircleBorder(),
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddProductPage()),
          );
          if (added == true) {
            // _refreshArticles();
          }
        },
        tooltip: 'Add Article',
        child: const Icon(Icons.add),
      ),
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
// * Better way of making card
Widget _productBuilder() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.95, // * change size of the box
    ),
    itemCount: 5,
    padding: EdgeInsets.all(16),
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 5, // shadow
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(child: Container(color: Colors.amber)),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Product Name"), Text("Price: 20")],
              ),
            ],
          ),
        ),
      );
    },
  );
}

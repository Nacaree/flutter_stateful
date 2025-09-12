import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int? pid;
  String? name;
  double? price;
  String? description;
  String? createdAt;
  Product({
    this.pid,
    this.name,
    this.price,
    this.description,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'name': name,
      'price': price,
      'description': description,
      'createdAt': createdAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      pid: map['pid'] != null ? map['pid'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      description: map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(pid: $pid, name: $name, price: $price, description: $description, createdAt: $createdAt)';
  }
}
